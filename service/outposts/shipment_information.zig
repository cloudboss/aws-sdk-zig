const ShipmentCarrier = @import("shipment_carrier.zig").ShipmentCarrier;

/// Information about a line item shipment.
pub const ShipmentInformation = struct {
    /// The carrier of the shipment.
    shipment_carrier: ?ShipmentCarrier,

    /// The tracking number of the shipment.
    shipment_tracking_number: ?[]const u8,

    pub const json_field_names = .{
        .shipment_carrier = "ShipmentCarrier",
        .shipment_tracking_number = "ShipmentTrackingNumber",
    };
};
