
import '../models/models.dart';

// ExploreData serves as a data container that holds 
//list of restaurants, food categories, and friend posts.
class ExploreData {
  final List<Gym> gyms;
  final List<ExerciseCategory> categories;
  final List<Post> friendPosts;

  ExploreData(this.gyms, this.categories, this.friendPosts);
}

// Mock Yummy service that grabs sample data to mock up a food app request/response
class MockYummyService {
  // Batch request that gets both today recipes and friend's feed
  Future<ExploreData> getExploreData() async {
    final gyms = await _getGyms();
    final categories = await _getCategories();
    final friendPosts = await _getFriendFeed();

    return ExploreData(gyms, categories, friendPosts);
  }

  // Get sample food categories to display in ui
  Future<List<ExerciseCategory>> _getCategories() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 100));
    // Return mock categories
    return categories;
  }

  // Get the friend posts to display in ui
  Future<List<Post>> _getFriendFeed() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 100));
    // Return mock posts
    return posts;
  }

  // Get the restaurants to display in ui
  Future<List<Gym>> _getGyms() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Return mock restaurants
    return gyms;
  }
}
