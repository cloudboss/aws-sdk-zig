const SOA = @import("soa.zig").SOA;

/// DNS properties for
/// the public DNS namespace.
pub const PublicDnsPropertiesMutable = struct {
    /// Start of Authority
    /// (SOA) record for the hosted zone for the public DNS namespace.
    soa: SOA,

    pub const json_field_names = .{
        .soa = "SOA",
    };
};
