const ClientPolicyTls = @import("client_policy_tls.zig").ClientPolicyTls;

/// An object that represents a client policy.
pub const ClientPolicy = struct {
    /// A reference to an object that represents a Transport Layer Security (TLS)
    /// client policy.
    tls: ?ClientPolicyTls,

    pub const json_field_names = .{
        .tls = "tls",
    };
};
