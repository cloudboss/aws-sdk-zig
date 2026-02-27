/// Details new geolocations used either at the resource or account level. For
/// example, lists an observed geolocation that is an infrequent or unused
/// location based on previous user activity.
pub const NewGeolocationDetail = struct {
    /// IP address using which the resource was accessed.
    ip_address: ?[]const u8,

    /// Checks if the geolocation is new for the entire account.
    is_new_for_entire_account: bool = false,

    /// Location where the resource was accessed.
    location: ?[]const u8,

    pub const json_field_names = .{
        .ip_address = "IpAddress",
        .is_new_for_entire_account = "IsNewForEntireAccount",
        .location = "Location",
    };
};
