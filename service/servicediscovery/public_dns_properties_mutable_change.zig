const SOAChange = @import("soa_change.zig").SOAChange;

/// Updated DNS
/// properties for the public DNS namespace.
pub const PublicDnsPropertiesMutableChange = struct {
    /// Updated fields for
    /// the Start of Authority (SOA) record for the hosted zone for the public DNS
    /// namespace.
    soa: SOAChange,

    pub const json_field_names = .{
        .soa = "SOA",
    };
};
