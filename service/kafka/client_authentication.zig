const Sasl = @import("sasl.zig").Sasl;
const Tls = @import("tls.zig").Tls;
const Unauthenticated = @import("unauthenticated.zig").Unauthenticated;

/// Includes all client authentication information.
pub const ClientAuthentication = struct {
    /// Details for ClientAuthentication using SASL.
    sasl: ?Sasl,

    /// Details for ClientAuthentication using TLS.
    tls: ?Tls,

    /// Contains information about unauthenticated traffic to the cluster.
    unauthenticated: ?Unauthenticated,

    pub const json_field_names = .{
        .sasl = "Sasl",
        .tls = "Tls",
        .unauthenticated = "Unauthenticated",
    };
};
