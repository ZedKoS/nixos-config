{ ... }:
{
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "en_GB.UTF-8/UTF-8"
    "it_IT.UTF-8/UTF-8"
  ];

  i18n.extraLocaleSettings = {
    LC_MEASUREMENT = "it_IT.UTF-8/UTF-8";
    LC_TELEPHONE = "it_IT.UTF-8/UTF-8";
    LC_TIME = "en_GB.UTF-8/UTF-8";
  };
}
