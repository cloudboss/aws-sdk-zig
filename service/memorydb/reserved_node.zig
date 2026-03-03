const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// Represents the output of a `PurchaseReservedNodesOffering` operation.
pub const ReservedNode = struct {
    /// The Amazon Resource Name (ARN) of the reserved node.
    arn: ?[]const u8 = null,

    /// The duration of the reservation in seconds.
    duration: i32 = 0,

    /// The fixed price charged for this reserved node.
    fixed_price: f64 = 0,

    /// The number of nodes that have been reserved.
    node_count: i32 = 0,

    /// The node type for the reserved nodes.
    node_type: ?[]const u8 = null,

    /// The offering type of this reserved node.
    offering_type: ?[]const u8 = null,

    /// The recurring price charged to run this reserved node.
    recurring_charges: ?[]const RecurringCharge = null,

    /// A customer-specified identifier to track this reservation.
    reservation_id: ?[]const u8 = null,

    /// The ID of the reserved node offering to purchase.
    reserved_nodes_offering_id: ?[]const u8 = null,

    /// The time the reservation started.
    start_time: ?i64 = null,

    /// The state of the reserved node.
    state: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "ARN",
        .duration = "Duration",
        .fixed_price = "FixedPrice",
        .node_count = "NodeCount",
        .node_type = "NodeType",
        .offering_type = "OfferingType",
        .recurring_charges = "RecurringCharges",
        .reservation_id = "ReservationId",
        .reserved_nodes_offering_id = "ReservedNodesOfferingId",
        .start_time = "StartTime",
        .state = "State",
    };
};
