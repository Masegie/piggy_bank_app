class AssetUtil {
  static String assetImage(int amount) {
    switch (amount) {
      case 1000:
        return 'assets/seribu.png';
      case 2000:
        return 'assets/2ribu.png';
      case 5000:
        return 'assets/5ribu.png';
      case 10000:
        return 'assets/10ribu.png';
      case 20000:
        return 'assets/20ribu.png';
      case 50000:
        return 'assets/50ribu.png';
      case 100000:
        return 'assets/100ribu.png';
      default:
        return 'assets/custom.png';
    }
  }
}