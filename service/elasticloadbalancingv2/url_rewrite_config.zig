const RewriteConfig = @import("rewrite_config.zig").RewriteConfig;

/// Information about a URL rewrite transform. This transform matches a pattern
/// in the request URL and replaces it with the specified string.
pub const UrlRewriteConfig = struct {
    /// The URL rewrite transform to apply to the request. The transform consists of
    /// a regular expression to match and a replacement string.
    rewrites: ?[]const RewriteConfig,
};
