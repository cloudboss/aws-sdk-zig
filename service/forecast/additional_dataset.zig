const aws = @import("aws");

/// Describes an additional dataset. This object is part of the DataConfig
/// object. Forecast supports the Weather Index and Holidays additional
/// datasets.
///
/// **Weather Index**
///
/// The Amazon Forecast Weather Index is a built-in dataset that incorporates
/// historical and
/// projected weather information into your model. The Weather Index supplements
/// your
/// datasets with over two years of historical weather data and up to 14 days of
/// projected
/// weather data. For more information, see [Amazon Forecast
/// Weather Index](https://docs.aws.amazon.com/forecast/latest/dg/weather.html).
///
/// **Holidays**
///
/// Holidays is a built-in dataset that incorporates national holiday
/// information into
/// your model. It provides native support for the holiday calendars of 66
/// countries. To
/// view the holiday calendars, refer to the
/// [Jollyday](http://jollyday.sourceforge.net/data.html) library. For more
/// information, see [Holidays
/// Featurization](https://docs.aws.amazon.com/forecast/latest/dg/holidays.html).
pub const AdditionalDataset = struct {
    /// **Weather Index**
    ///
    /// To enable the Weather Index, do not specify a value for
    /// `Configuration`.
    ///
    /// **Holidays**
    ///
    /// **Holidays**
    ///
    /// To enable Holidays, set `CountryCode` to one of the following two-letter
    /// country codes:
    ///
    /// * "AL" - ALBANIA
    ///
    /// * "AR" - ARGENTINA
    ///
    /// * "AT" - AUSTRIA
    ///
    /// * "AU" - AUSTRALIA
    ///
    /// * "BA" - BOSNIA HERZEGOVINA
    ///
    /// * "BE" - BELGIUM
    ///
    /// * "BG" - BULGARIA
    ///
    /// * "BO" - BOLIVIA
    ///
    /// * "BR" - BRAZIL
    ///
    /// * "BY" - BELARUS
    ///
    /// * "CA" - CANADA
    ///
    /// * "CL" - CHILE
    ///
    /// * "CO" - COLOMBIA
    ///
    /// * "CR" - COSTA RICA
    ///
    /// * "HR" - CROATIA
    ///
    /// * "CZ" - CZECH REPUBLIC
    ///
    /// * "DK" - DENMARK
    ///
    /// * "EC" - ECUADOR
    ///
    /// * "EE" - ESTONIA
    ///
    /// * "ET" - ETHIOPIA
    ///
    /// * "FI" - FINLAND
    ///
    /// * "FR" - FRANCE
    ///
    /// * "DE" - GERMANY
    ///
    /// * "GR" - GREECE
    ///
    /// * "HU" - HUNGARY
    ///
    /// * "IS" - ICELAND
    ///
    /// * "IN" - INDIA
    ///
    /// * "IE" - IRELAND
    ///
    /// * "IT" - ITALY
    ///
    /// * "JP" - JAPAN
    ///
    /// * "KZ" - KAZAKHSTAN
    ///
    /// * "KR" - KOREA
    ///
    /// * "LV" - LATVIA
    ///
    /// * "LI" - LIECHTENSTEIN
    ///
    /// * "LT" - LITHUANIA
    ///
    /// * "LU" - LUXEMBOURG
    ///
    /// * "MK" - MACEDONIA
    ///
    /// * "MT" - MALTA
    ///
    /// * "MX" - MEXICO
    ///
    /// * "MD" - MOLDOVA
    ///
    /// * "ME" - MONTENEGRO
    ///
    /// * "NL" - NETHERLANDS
    ///
    /// * "NZ" - NEW ZEALAND
    ///
    /// * "NI" - NICARAGUA
    ///
    /// * "NG" - NIGERIA
    ///
    /// * "NO" - NORWAY
    ///
    /// * "PA" - PANAMA
    ///
    /// * "PY" - PARAGUAY
    ///
    /// * "PE" - PERU
    ///
    /// * "PL" - POLAND
    ///
    /// * "PT" - PORTUGAL
    ///
    /// * "RO" - ROMANIA
    ///
    /// * "RU" - RUSSIA
    ///
    /// * "RS" - SERBIA
    ///
    /// * "SK" - SLOVAKIA
    ///
    /// * "SI" - SLOVENIA
    ///
    /// * "ZA" - SOUTH AFRICA
    ///
    /// * "ES" - SPAIN
    ///
    /// * "SE" - SWEDEN
    ///
    /// * "CH" - SWITZERLAND
    ///
    /// * "UA" - UKRAINE
    ///
    /// * "AE" - UNITED ARAB EMIRATES
    ///
    /// * "US" - UNITED STATES
    ///
    /// * "UK" - UNITED KINGDOM
    ///
    /// * "UY" - URUGUAY
    ///
    /// * "VE" - VENEZUELA
    configuration: ?[]const aws.map.MapEntry([]const []const u8),

    /// The name of the additional dataset. Valid names: `"holiday"` and
    /// `"weather"`.
    name: []const u8,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .name = "Name",
    };
};
