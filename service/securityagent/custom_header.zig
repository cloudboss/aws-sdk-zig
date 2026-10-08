/// A custom HTTP header to include in network traffic during penetration
/// testing.
pub const CustomHeader = struct {
    /// The name of the custom header.
    name: ?[]const u8 = null,

    /// The value of the custom header.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
