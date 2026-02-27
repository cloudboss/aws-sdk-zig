const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const ReservedNodeOfferingType = @import("reserved_node_offering_type.zig").ReservedNodeOfferingType;

/// Describes a reserved node. You can call the DescribeReservedNodeOfferings
/// API to obtain the available reserved node
/// offerings.
pub const ReservedNode = struct {
    /// The currency code for the reserved cluster.
    currency_code: ?[]const u8,

    /// The duration of the node reservation in seconds.
    duration: ?i32,

    /// The fixed cost Amazon Redshift charges you for this reserved node.
    fixed_price: ?f64,

    /// The number of reserved compute nodes.
    node_count: ?i32,

    /// The node type of the reserved node.
    node_type: ?[]const u8,

    /// The anticipated utilization of the reserved node, as defined in the reserved
    /// node
    /// offering.
    offering_type: ?[]const u8,

    /// The recurring charges for the reserved node.
    recurring_charges: ?[]const RecurringCharge,

    /// The unique identifier for the reservation.
    reserved_node_id: ?[]const u8,

    /// The identifier for the reserved node offering.
    reserved_node_offering_id: ?[]const u8,

    reserved_node_offering_type: ?ReservedNodeOfferingType,

    /// The time the reservation started. You purchase a reserved node offering for
    /// a
    /// duration. This is the start time of that duration.
    start_time: ?i64,

    /// The state of the reserved compute node.
    ///
    /// Possible Values:
    ///
    /// * pending-payment-This reserved node has recently been purchased, and the
    /// sale has been approved, but payment has not yet been confirmed.
    ///
    /// * active-This reserved node is owned by the caller and is available for
    /// use.
    ///
    /// * payment-failed-Payment failed for the purchase attempt.
    ///
    /// * retired-The reserved node is no longer available.
    ///
    /// * exchanging-The owner is exchanging the reserved node for another reserved
    /// node.
    state: ?[]const u8,

    /// The hourly rate Amazon Redshift charges you for this reserved node.
    usage_price: ?f64,
};
