/// The `Status` and `TrackingNumber` information for an inbound or
/// outbound shipment.
pub const Shipment = struct {
    /// Status information for a shipment.
    status: ?[]const u8 = null,

    /// The tracking number for this job. Using this tracking number with your
    /// region's
    /// carrier's website, you can track a Snow device as the carrier transports it.
    ///
    /// For India, the carrier is Amazon Logistics. For all other regions, UPS is
    /// the
    /// carrier.
    tracking_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .tracking_number = "TrackingNumber",
    };
};
