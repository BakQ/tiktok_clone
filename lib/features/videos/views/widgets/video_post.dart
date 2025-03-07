// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'video_button.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

/**With ~Mixin : 해당 클래스를 복사해오겠다는 의미 
 * vsync : 불필요한 리소스 사용을 방지 (위젯이 안보일 때는 애니메이션이 작동하지 않음)
 * SingleTickerProviderStateMixin : 매 프레임마다 callback 을 호출
 * - 단, 위젯이 화면에 있을 때만 작동함
 * - 애니메이션이 여러 개라면, TickerProviderStateMixin 사용
 */
class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  // VideoPlayerController 사용 시, initialize() 로 초기화 해주어야 영상을 불러올 수 있음
  // final VideoPlayerController _videoPlayerController = VideoPlayerController.asset("assets/videos/video01.mp4");
  late final VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;

  final Duration _animationDuration = const Duration(milliseconds: 200);
  bool _isPaused = false;

  bool _autoMute = videoConfig.value;

  final bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0, // 크기 지정
      upperBound: 1.5, // 크기 지정
      value: 1.5, // default 크기
      duration: _animationDuration,
    );

    videoConfig.addListener(() {
      setState(() {
        _autoMute = videoConfig.value;
      });
    });
    /**_animationController.reverse()
     * 수행 시, 1.5 => 1.0 으로 값이 바뀌게 되는데,
     * build() 는 1.5, 1.0 일 때만 재수행 되고 있음
     * build() 가 값이 바뀌는 것을 알게 하려면? _animationController 에 이벤트 리스너 추가
     * 모든 단계에서 build 메서드를 실행하기 위해 이벤트 리스너에 setState() 추가
     */
    // _animationController.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    final muted = ref.read(playbackConfigProvider).muted;
    ref.read(playbackConfigProvider.notifier).setMuted(!muted);
    if (muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/videos/video01.mp4");
    await _videoPlayerController.initialize(); // 초기화
    // _videoPlayerController.play(); // 자동 재생 X
    // 영상이 반복되도록 설정 (7.8 Video UI)
    await _videoPlayerController.setLooping(true);
    setState(() {});
    // 영상이 끝났는지 확인하기 위한 Listener
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _onVideoChange() {
    // 초기화 되었는지
    if (_videoPlayerController.value.isInitialized) {
      // 영상 길이가 현재 영상 내 위치와 같은지
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  // Widget 이 다 보이는데, 동영상이 재생 중이 아니면 재생하기
  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    // Offstage 사용해서 dispose 안됌 그래서 다른탭 들어가면 멈추게 함
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  // 재생 중이면 일시정지, 일시정지면 재생
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // lowerBound
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // upperBound
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

//댓글
  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    // 이 await 는 사용자가 BottomSheet 를 닫을 때 resolve 됨
    await showModalBottomSheet(
      context: context, // context 를 받아옴
      /**The [isScrollControlled] parameter specifies whether this is a route for a bottom sheet that will utilize [DraggableScrollableSheet]. Consider setting this parameter to true if this bottom sheet has a scrollable child, such as a [ListView] or a [GridView], to have the bottom sheet be draggable.
       * BottomSheet 에서 ListView 사용 시 true 설정해야 한다고 함
       */
      isScrollControlled: true, // BottomSheet 크기 조절 시 true 로 설정해야 함
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          // Positioned.fill : 화면 전체를 채움
          Positioned.fill(
            // 초기화 되었으면 video 를 재생, 아니면 검은 화면
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            // 클릭 이벤트를 무시하도록 함 (위의 _onTogglePause 가 먹도록)
            child: IgnorePointer(
              child: Center(
                // 사이즈 조절을 위해 AnimationController 사용
                child: AnimatedBuilder(
                  animation: _animationController,
                  // AnimatedBuilder 가 애니메이션의 변화를 감지하고, builder 가 최신 값으로 return 하도록 함
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  // Animated Widget 을 사용
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: _onPlaybackConfigChanged,
            ),
          ),
          const Positioned(
            bottom: 30,
            left: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@BakQ",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "Snow Snow Snow Snow", // todo: See more Code Challenge
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            right: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/27847451",
                  ),
                  child: Text(
                    "BakQ",
                    style: TextStyle(fontSize: Sizes.size8),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "4.9M",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
