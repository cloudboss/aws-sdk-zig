/// Specifies a single cookie or set of cookies in an end user's browser.
pub const CookieSpecification = struct {
    /// The domain of the cookie.
    domain: []const u8,

    /// The name of the cookie.
    name: ?[]const u8,

    /// The path of the cookie.
    path: ?[]const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .name = "name",
        .path = "path",
    };
};
