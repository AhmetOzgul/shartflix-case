import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'lottie_heart_animation.dart';

class MovieDetailCard extends StatefulWidget {
  final Movie movie;

  const MovieDetailCard({super.key, required this.movie});

  @override
  State<MovieDetailCard> createState() => _MovieDetailCardState();
}

class _MovieDetailCardState extends State<MovieDetailCard> {
  bool _isDescriptionExpanded = false;
  bool _showHeartAnimation = false;
  bool _wasFavorite = false;

  @override
  void initState() {
    super.initState();
    _wasFavorite = widget.movie.isFavorite;
  }

  void _showHeartAnimationEffect() {
    setState(() {
      _showHeartAnimation = true;
    });
  }

  void _hideHeartAnimation() {
    setState(() {
      _showHeartAnimation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.movie.poster,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            memCacheWidth: 1080,
            memCacheHeight: 1920,
            placeholder: (context, url) => Container(color: Colors.grey[900]),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[800],
              child: const Icon(Icons.movie, color: Colors.white, size: 48),
            ),
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 100),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final isFavoriteLoading =
                  state is HomeLoaded && state.isFavoriteLoading;

              if (state is HomeLoaded) {
                final currentMovie = state.movies.firstWhere(
                  (movie) => movie.id == widget.movie.id,
                  orElse: () => widget.movie,
                );
                if (!_wasFavorite &&
                    currentMovie.isFavorite &&
                    !_showHeartAnimation) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _showHeartAnimationEffect();
                  });
                }
                _wasFavorite = currentMovie.isFavorite;
              }

              return Positioned(
                bottom: MediaQuery.of(context).size.height * 0.2,
                right: 15,
                child: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.onPrimary.withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: IconButton(
                    onPressed: isFavoriteLoading
                        ? null
                        : () {
                            context.read<HomeBloc>().add(
                              ToggleFavorite(movieId: widget.movie.id),
                            );
                          },
                    icon: isFavoriteLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            widget.movie.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                            size: 30,
                          ),
                  ),
                ),
              );
            },
          ),

          if (_showHeartAnimation)
            Positioned.fill(
              child: LottieHeartAnimation(
                onAnimationComplete: _hideHeartAnimation,
              ),
            ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.movie,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isDescriptionExpanded =
                                      !_isDescriptionExpanded;
                                });
                              },
                              child: AnimatedCrossFade(
                                duration: const Duration(milliseconds: 300),
                                crossFadeState: _isDescriptionExpanded
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                firstChild: Text(
                                  widget.movie.plot.length > 100
                                      ? '${widget.movie.plot.substring(0, 100)}...'
                                      : widget.movie.plot,
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                secondChild: Text(
                                  widget.movie.plot,
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isDescriptionExpanded = !_isDescriptionExpanded;
                          });
                        },
                        child: Text(
                          _isDescriptionExpanded
                              ? 'home.less'.tr()
                              : 'home.more'.tr(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
