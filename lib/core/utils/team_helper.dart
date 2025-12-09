class TeamHelper {
  /// Mapea el nombre del equipo al path de su ícono
  static String getTeamIcon(String teamName) {
    final Map<String, String> teamIcons = {
      'Wilstermann': 'assets/images/equipos/wilstermann.png',
      'Bolívar': 'assets/images/equipos/bolivar.png',
      'The Strongest': 'assets/images/equipos/the_strongest.png',
      'Blooming': 'assets/images/equipos/blooming.png',
      'Aurora': 'assets/images/equipos/aurora.png',
      'San José': 'assets/images/equipos/san_ose.png',
      'Nacional Potosí': 'assets/images/equipos/nacional_potosi.png',
      'Oriente Petrolero': 'assets/images/equipos/oriente_petrolero.png',
      'Real Tomayapo': 'assets/images/equipos/real_tomayapo.png',
      'Guabirá': 'assets/images/equipos/guabira.png',
      'Universitario': 'assets/images/equipos/Universitario.png',
      'Independiente': 'assets/images/equipos/independiente.png',
    };

    return teamIcons[teamName] ?? 'assets/images/equipos/default.png';
  }

  /// Retorna true si el equipo es Wilstermann
  static bool isWilstermann(String teamName) {
    return teamName.toLowerCase().contains('wilstermann');
  }
}
