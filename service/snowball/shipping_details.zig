const Shipment = @import("shipment.zig").Shipment;
const ShippingOption = @import("shipping_option.zig").ShippingOption;

/// A job's shipping information, including inbound and outbound tracking
/// numbers and
/// shipping speed options.
pub const ShippingDetails = struct {
    /// The `Status` and `TrackingNumber` values for a Snow device being
    /// returned to Amazon Web Services for a particular job.
    inbound_shipment: ?Shipment = null,

    /// The `Status` and `TrackingNumber` values for a Snow device being
    /// delivered to the address that you specified for a particular job.
    outbound_shipment: ?Shipment = null,

    /// The shipping speed for a particular job. This speed doesn't dictate how soon
    /// you'll get
    /// the Snow device from the job's creation date. This speed represents how
    /// quickly it moves to
    /// its destination while in transit. Regional shipping speeds are as follows:
    ///
    /// * In Australia, you have access to express shipping. Typically, Snow devices
    ///   shipped
    /// express are delivered in about a day.
    ///
    /// * In the European Union (EU), you have access to express shipping.
    ///   Typically, Snow
    /// devices shipped express are delivered in about a day. In addition, most
    /// countries in the
    /// EU have access to standard shipping, which typically takes less than a week,
    /// one
    /// way.
    ///
    /// * In India, Snow devices are delivered in one to seven days.
    ///
    /// * In the United States of America (US), you have access to one-day shipping
    ///   and
    /// two-day shipping.
    shipping_option: ?ShippingOption = null,

    pub const json_field_names = .{
        .inbound_shipment = "InboundShipment",
        .outbound_shipment = "OutboundShipment",
        .shipping_option = "ShippingOption",
    };
};
