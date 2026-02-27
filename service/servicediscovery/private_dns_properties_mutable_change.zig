const SOAChange = @import("soa_change.zig").SOAChange;

/// Updated DNS
/// properties for the private DNS namespace.
pub const PrivateDnsPropertiesMutableChange = struct {
    /// Updated fields for
    /// the Start of Authority (SOA) record for the hosted zone for the private DNS
    /// namespace.
    soa: SOAChange,

    pub const json_field_names = .{
        .soa = "SOA",
    };
};
