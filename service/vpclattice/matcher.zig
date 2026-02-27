/// Describes the codes to use when checking for a successful response from a
/// target for health checks.
pub const Matcher = union(enum) {
    /// The HTTP code to use when checking for a successful response from a target.
    http_code: ?[]const u8,

    pub const json_field_names = .{
        .http_code = "httpCode",
    };
};
