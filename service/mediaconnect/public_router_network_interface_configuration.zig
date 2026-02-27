const PublicRouterNetworkInterfaceRule = @import("public_router_network_interface_rule.zig").PublicRouterNetworkInterfaceRule;

/// The configuration settings for a public router network interface, including
/// the list of allowed CIDR blocks.
pub const PublicRouterNetworkInterfaceConfiguration = struct {
    /// The list of allowed CIDR blocks for the public router network interface.
    allow_rules: []const PublicRouterNetworkInterfaceRule,

    pub const json_field_names = .{
        .allow_rules = "AllowRules",
    };
};
