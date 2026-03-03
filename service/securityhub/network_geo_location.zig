/// Contains information about the location of a network endpoint involved in an
/// Amazon GuardDuty Extended Threat Detection attack sequence.
/// GuardDuty generates an attack
/// sequence finding when multiple events align to a potentially suspicious
/// activity. To receive GuardDuty attack sequence findings in Security Hub, you
/// must have GuardDuty enabled. For more information, see [GuardDuty Extended
/// Threat Detection
/// ](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty-extended-threat-detection.html) in the *Amazon GuardDuty User Guide*.
pub const NetworkGeoLocation = struct {
    /// The name of the city.
    city: ?[]const u8 = null,

    /// The name of the country.
    country: ?[]const u8 = null,

    /// The latitude information of the endpoint location.
    lat: ?f64 = null,

    /// The longitude information of the endpoint location.
    lon: ?f64 = null,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .lat = "Lat",
        .lon = "Lon",
    };
};
