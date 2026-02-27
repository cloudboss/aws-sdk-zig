const VirtualGatewayClientPolicy = @import("virtual_gateway_client_policy.zig").VirtualGatewayClientPolicy;

/// An object that represents the default properties for a backend.
pub const VirtualGatewayBackendDefaults = struct {
    /// A reference to an object that represents a client policy.
    client_policy: ?VirtualGatewayClientPolicy,

    pub const json_field_names = .{
        .client_policy = "clientPolicy",
    };
};
