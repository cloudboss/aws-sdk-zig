const All = @import("all.zig").All;

/// The filter to use to identify the subset of cookies to inspect in a web
/// request.
///
/// You must specify exactly one setting: either `All`, `IncludedCookies`, or
/// `ExcludedCookies`.
///
/// Example JSON: `"MatchPattern": { "IncludedCookies": [ "session-id-time",
/// "session-id" ] }`
pub const CookieMatchPattern = struct {
    /// Inspect all cookies.
    all: ?All,

    /// Inspect only the cookies whose keys don't match any of the strings specified
    /// here.
    excluded_cookies: ?[]const []const u8,

    /// Inspect only the cookies that have a key that matches one of the strings
    /// specified here.
    included_cookies: ?[]const []const u8,

    pub const json_field_names = .{
        .all = "All",
        .excluded_cookies = "ExcludedCookies",
        .included_cookies = "IncludedCookies",
    };
};
