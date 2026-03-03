const RewriteConfig = @import("rewrite_config.zig").RewriteConfig;

/// Information about a host header rewrite transform. This transform matches a
/// pattern in the host header in an HTTP request and replaces it with the
/// specified string.
pub const HostHeaderRewriteConfig = struct {
    /// The host header rewrite transform. Each transform consists of a regular
    /// expression to match and a replacement string.
    rewrites: ?[]const RewriteConfig = null,
};
