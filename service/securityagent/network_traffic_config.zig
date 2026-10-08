const CustomHeader = @import("custom_header.zig").CustomHeader;
const NetworkTrafficRule = @import("network_traffic_rule.zig").NetworkTrafficRule;

/// The network traffic configuration for a pentest, including custom headers
/// and traffic rules.
pub const NetworkTrafficConfig = struct {
    /// The list of custom HTTP headers to include in network traffic during
    /// testing.
    custom_headers: ?[]const CustomHeader = null,

    /// The list of network traffic rules that control which URLs are allowed or
    /// denied during testing.
    rules: ?[]const NetworkTrafficRule = null,

    pub const json_field_names = .{
        .custom_headers = "customHeaders",
        .rules = "rules",
    };
};
