/// The context data that your application submitted in an authentication
/// request with
/// threat protection, as displayed in an `AdminListUserAuthEvents`
/// response.
pub const EventContextDataType = struct {
    /// The user's city.
    city: ?[]const u8 = null,

    /// The user's country.
    country: ?[]const u8 = null,

    /// The user's device name.
    device_name: ?[]const u8 = null,

    /// The source IP address of your user's device.
    ip_address: ?[]const u8 = null,

    /// The user's time zone.
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .city = "City",
        .country = "Country",
        .device_name = "DeviceName",
        .ip_address = "IpAddress",
        .timezone = "Timezone",
    };
};
