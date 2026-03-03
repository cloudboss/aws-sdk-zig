const VirtualGatewayClientPolicyTls = @import("virtual_gateway_client_policy_tls.zig").VirtualGatewayClientPolicyTls;

/// An object that represents a client policy.
pub const VirtualGatewayClientPolicy = struct {
    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// client policy.
    tls: ?VirtualGatewayClientPolicyTls = null,

    pub const json_field_names = .{
        .tls = "tls",
    };
};
