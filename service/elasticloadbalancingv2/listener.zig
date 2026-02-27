const Certificate = @import("certificate.zig").Certificate;
const Action = @import("action.zig").Action;
const MutualAuthenticationAttributes = @import("mutual_authentication_attributes.zig").MutualAuthenticationAttributes;
const ProtocolEnum = @import("protocol_enum.zig").ProtocolEnum;

/// Information about a listener.
pub const Listener = struct {
    /// [TLS listener] The name of the Application-Layer Protocol Negotiation (ALPN)
    /// policy.
    alpn_policy: ?[]const []const u8,

    /// [HTTPS or TLS listener] The default certificate for the listener.
    certificates: ?[]const Certificate,

    /// The default actions for the listener.
    default_actions: ?[]const Action,

    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the load balancer.
    load_balancer_arn: ?[]const u8,

    /// The mutual authentication configuration information.
    mutual_authentication: ?MutualAuthenticationAttributes,

    /// The port on which the load balancer is listening.
    port: ?i32,

    /// The protocol for connections from clients to the load balancer.
    protocol: ?ProtocolEnum,

    /// [HTTPS or TLS listener] The security policy that defines which protocols and
    /// ciphers are
    /// supported.
    ssl_policy: ?[]const u8,
};
