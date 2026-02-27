/// Configuration for HTTP request headers that will be passed through to the
/// runtime.
pub const RequestHeaderConfiguration = union(enum) {
    /// A list of HTTP request headers that are allowed to be passed through to the
    /// runtime.
    request_header_allowlist: ?[]const []const u8,

    pub const json_field_names = .{
        .request_header_allowlist = "requestHeaderAllowlist",
    };
};
