/// Describes a location.
pub const Location = struct {
    /// The physical address.
    address: ?[]const u8,

    /// The latitude.
    latitude: ?[]const u8,

    /// The longitude.
    longitude: ?[]const u8,

    pub const json_field_names = .{
        .address = "Address",
        .latitude = "Latitude",
        .longitude = "Longitude",
    };
};
