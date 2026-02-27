const CookieSpecification = @import("cookie_specification.zig").CookieSpecification;

/// The configuration that specifies which cookies should be synchronized from
/// the end user's local browser to the remote browser.
pub const CookieSynchronizationConfiguration = struct {
    /// The list of cookie specifications that are allowed to be synchronized to the
    /// remote browser.
    allowlist: []const CookieSpecification,

    /// The list of cookie specifications that are blocked from being synchronized
    /// to the remote browser.
    blocklist: ?[]const CookieSpecification,

    pub const json_field_names = .{
        .allowlist = "allowlist",
        .blocklist = "blocklist",
    };
};
