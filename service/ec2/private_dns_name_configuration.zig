const DnsNameState = @import("dns_name_state.zig").DnsNameState;

/// Information about the private DNS name for the service endpoint.
pub const PrivateDnsNameConfiguration = struct {
    /// The name of the record subdomain the service provider needs to create. The
    /// service provider adds the `value` text to the `name`.
    name: ?[]const u8,

    /// The verification state of the VPC endpoint service.
    ///
    /// Consumers
    /// of the endpoint service can use the private name only when the state is
    /// `verified`.
    state: ?DnsNameState,

    /// The endpoint service verification type, for example TXT.
    type: ?[]const u8,

    /// The value the service provider adds to the private DNS name domain record
    /// before verification.
    value: ?[]const u8,
};
