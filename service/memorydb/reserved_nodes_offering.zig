const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;

/// The offering type of this node.
pub const ReservedNodesOffering = struct {
    /// The duration of the reservation in seconds.
    duration: i32 = 0,

    /// The fixed price charged for this reserved node.
    fixed_price: f64 = 0,

    /// The node type for the reserved nodes. For more information, see [Supported
    /// node
    /// types](https://docs.aws.amazon.com/memorydb/latest/devguide/nodes.reserved.html#reserved-nodes-supported).
    node_type: ?[]const u8 = null,

    /// The offering type of this reserved node.
    offering_type: ?[]const u8 = null,

    /// The recurring price charged to run this reserved node.
    recurring_charges: ?[]const RecurringCharge = null,

    /// The offering identifier.
    reserved_nodes_offering_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration = "Duration",
        .fixed_price = "FixedPrice",
        .node_type = "NodeType",
        .offering_type = "OfferingType",
        .recurring_charges = "RecurringCharges",
        .reserved_nodes_offering_id = "ReservedNodesOfferingId",
    };
};
