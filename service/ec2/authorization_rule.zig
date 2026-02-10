const ClientVpnAuthorizationRuleStatus = @import("client_vpn_authorization_rule_status.zig").ClientVpnAuthorizationRuleStatus;

/// Information about an authorization rule.
pub const AuthorizationRule = struct {
    /// Indicates whether the authorization rule grants access to all clients.
    access_all: ?bool,

    /// The ID of the Client VPN endpoint with which the authorization rule is
    /// associated.
    client_vpn_endpoint_id: ?[]const u8,

    /// A brief description of the authorization rule.
    description: ?[]const u8,

    /// The IPv4 address range, in CIDR notation, of the network to which the
    /// authorization rule applies.
    destination_cidr: ?[]const u8,

    /// The ID of the Active Directory group to which the authorization rule grants
    /// access.
    group_id: ?[]const u8,

    /// The current state of the authorization rule.
    status: ?ClientVpnAuthorizationRuleStatus,
};
