/// A complex type that contains the name of an HTTP namespace.
pub const HttpProperties = struct {
    /// The name of an HTTP namespace.
    http_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .http_name = "HttpName",
    };
};
