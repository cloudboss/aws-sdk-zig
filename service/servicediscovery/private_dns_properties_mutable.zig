const SOA = @import("soa.zig").SOA;

/// DNS properties for
/// the private DNS namespace.
pub const PrivateDnsPropertiesMutable = struct {
    /// Fields for the Start
    /// of Authority (SOA) record for the hosted zone for the private DNS
    /// namespace.
    soa: SOA,

    pub const json_field_names = .{
        .soa = "SOA",
    };
};
