const ClientVpnAuthorizationRuleStatusCode = @import("client_vpn_authorization_rule_status_code.zig").ClientVpnAuthorizationRuleStatusCode;

/// Describes the state of an authorization rule.
pub const ClientVpnAuthorizationRuleStatus = struct {
    /// The state of the authorization rule.
    code: ?ClientVpnAuthorizationRuleStatusCode = null,

    /// A message about the status of the authorization rule, if applicable.
    message: ?[]const u8 = null,
};
