class Team {
  final String id;
  final String name;
  final String description;

  Team({
    required this.id,
    required this.name,
    required this.description,
  });
}

final List<Team> teams = [
  Team(
    id: '1',
    name: 'Engineering',
    description: 'Software development team',
  ),
  Team(
    id: '2',
    name: 'Design',
    description: 'UI/UX design team',
  ),
  Team(
    id: '3',
    name: 'Marketing',
    description: 'Marketing and communications team',
  ),
];
