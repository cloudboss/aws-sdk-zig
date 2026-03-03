/// Describes an account-specific API endpoint.
pub const Endpoint = struct {
    /// URL of endpoint
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "Url",
    };
};
