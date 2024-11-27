String getWeatherEmoji(String condition) {
  switch (condition.toLowerCase()) {
    case "cloudy":
      return "☁️";
    case "rainy":
      return "🌧️";
    case "sunny":
      return "☀️";
    case "snowy":
      return "❄️";
    case "stormy":
      return "⛈️";
    default:
      return "🌈";
  }
}
