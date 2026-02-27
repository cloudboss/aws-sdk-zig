/// The address domain associate with the tax information.
pub const Authority = struct {
    /// The country code for the country that the address is in.
    country: []const u8,

    /// The state that the address is located.
    state: ?[]const u8,

    pub const json_field_names = .{
        .country = "country",
        .state = "state",
    };
};
