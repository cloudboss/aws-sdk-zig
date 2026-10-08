/// Represents a target endpoint for penetration testing.
pub const Endpoint = struct {
    /// The URI of the endpoint.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
