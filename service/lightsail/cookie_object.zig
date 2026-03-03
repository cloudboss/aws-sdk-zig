const ForwardValues = @import("forward_values.zig").ForwardValues;

/// Describes whether an Amazon Lightsail content delivery network (CDN)
/// distribution forwards
/// cookies to the origin and, if so, which ones.
///
/// For the cookies that you specify, your distribution caches separate versions
/// of the
/// specified content based on the cookie values in viewer
/// requests.
pub const CookieObject = struct {
    /// The specific cookies to forward to your distribution's origin.
    cookies_allow_list: ?[]const []const u8 = null,

    /// Specifies which cookies to forward to the distribution's origin for a cache
    /// behavior:
    /// `all`, `none`, or `allow-list` to forward only the cookies
    /// specified in the `cookiesAllowList` parameter.
    option: ?ForwardValues = null,

    pub const json_field_names = .{
        .cookies_allow_list = "cookiesAllowList",
        .option = "option",
    };
};
