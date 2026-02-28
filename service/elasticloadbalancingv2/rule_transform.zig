const HostHeaderRewriteConfig = @import("host_header_rewrite_config.zig").HostHeaderRewriteConfig;
const TransformTypeEnum = @import("transform_type_enum.zig").TransformTypeEnum;
const UrlRewriteConfig = @import("url_rewrite_config.zig").UrlRewriteConfig;

/// Information about a transform to apply to requests that match a rule.
/// Transforms are applied to requests before they are sent to targets.
pub const RuleTransform = struct {
    /// Information about a host header rewrite transform. This transform modifies
    /// the host header in an HTTP request.
    /// Specify only when `Type` is `host-header-rewrite`.
    host_header_rewrite_config: ?HostHeaderRewriteConfig,

    /// The type of transform.
    ///
    /// * `host-header-rewrite` - Rewrite the host header.
    ///
    /// * `url-rewrite` - Rewrite the request URL.
    type: TransformTypeEnum,

    /// Information about a URL rewrite transform. This transform modifies the
    /// request URL.
    /// Specify only when `Type` is `url-rewrite`.
    url_rewrite_config: ?UrlRewriteConfig,
};
