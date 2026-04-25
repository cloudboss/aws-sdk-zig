/// Contains information about the location of the remote IP address. By
/// default, GuardDuty returns `Geolocation` with `Lat` and `Lon` as `0.0`.
pub const GeoLocation = struct {
    /// The latitude information of the remote IP address.
    lat: ?f64 = null,

    /// The longitude information of the remote IP address.
    lon: ?f64 = null,

    pub const json_field_names = .{
        .lat = "Lat",
        .lon = "Lon",
    };
};
