/// Provides information about the city that an IP address originated from.
pub const IpCity = struct {
    /// The name of the city.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
