import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists.dart';
import 'package:masinqo/domain/admin/admin_artists/admin_artists_repository_interface.dart';
import 'package:masinqo/application/admin/admin_state.dart';

class AdminArtistNotifier extends StateNotifier<AdminArtistsState> {
  final AdminArtistRepositoryInterface adminArtistRepo;

  AdminArtistNotifier({required this.adminArtistRepo})
      : super(AdminArtistsState(artists: [])) {
    getArtists();
  }

  Future<void> getArtists() async {
    final res = await AdminArtistsCollection(
      adminArtistsRepository: adminArtistRepo,
    ).getArtists();

    res.fold((l) {
      state = AdminArtistsState(artists: []);
      state.errorMessages = l.message;
    }, (r) {
      state = AdminArtistsState(artists: r.listeners);
    });
  }

  Future<void> deleteArtist(String artistId) async {
    final res = await AdminArtistsCollection(
      adminArtistsRepository: adminArtistRepo,
    ).deleteArtist(artistId);

    res.fold((l) {
      state = AdminArtistsState(artists: state.artists);
      state.errorMessages = l.message;
    }, (r) {
      final List<AdminArtist> res = [];
      for (int i = 0; i < state.artists.length; i++) {
        if (state.artists[i].id != artistId) {
          res.add(state.artists[i]);
        }
      }
      AdminArtistsState newState = AdminArtistsState(artists: res);
      state = newState;
    });
  }

  Future<void> changeArtistStatus(String artistId, bool newBannedStatus) async {
    final res = await AdminArtistsCollection(
      adminArtistsRepository: adminArtistRepo,
    ).changeStatus(artistId, newBannedStatus);

    res.fold((l) {
      state = AdminArtistsState(artists: state.artists);
      state.errorMessages = l.message;
    }, (r) {
      final List<AdminArtist> res = [];
      for (int i = 0; i < state.artists.length; i++) {
        if (state.artists[i].id == artistId) {
          state.artists[i].isBanned = !state.artists[i].isBanned;
        }
        res.add(state.artists[i]);
      }

      state = AdminArtistsState(artists: res);
    });
  }
}
