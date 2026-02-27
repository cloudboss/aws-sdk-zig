/// Provides information about the country that an IP address originated from.
pub const IpCountry = struct {
    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country that
    /// the IP address originated from. For example, US for the United States.
    code: ?[]const u8,

    /// The name of the country that the IP address originated from.
    name: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .name = "name",
    };
};
