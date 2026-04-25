const ExternalProxy = @import("external_proxy.zig").ExternalProxy;

/// Union type representing different proxy configurations. Currently supports
/// external customer-managed proxies.
pub const Proxy = union(enum) {
    /// Configuration for an external customer-managed proxy server.
    external_proxy: ?ExternalProxy,

    pub const json_field_names = .{
        .external_proxy = "externalProxy",
    };
};
