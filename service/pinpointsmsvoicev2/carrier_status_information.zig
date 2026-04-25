const CarrierStatus = @import("carrier_status.zig").CarrierStatus;

/// Contains carrier-level launch status details for an RCS agent within a
/// country.
pub const CarrierStatusInformation = struct {
    /// The name of the carrier.
    carrier_name: []const u8,

    /// The launch status for this carrier.
    status: CarrierStatus,

    pub const json_field_names = .{
        .carrier_name = "CarrierName",
        .status = "Status",
    };
};
