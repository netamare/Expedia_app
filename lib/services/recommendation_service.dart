class RecommendationService {
  // Simple static suggestions - in a real app this would be personalized.
  List<Map<String, String>> getTopDestinations() {
    return [
      {'name': 'Los Angeles', 'country': 'USA'},
      {'name': 'Paris', 'country': 'France'},
      {'name': 'Addis Ababa', 'country': 'Ethiopia'},
      {'name': 'Bangkok', 'country': 'Thailand'},
    ];
  }
}