const RecurringCharge = @import("recurring_charge.zig").RecurringCharge;
const ReservedNodeOfferingType = @import("reserved_node_offering_type.zig").ReservedNodeOfferingType;

/// Describes a reserved node offering.
pub const ReservedNodeOffering = struct {
    /// The currency code for the compute nodes offering.
    currency_code: ?[]const u8,

    /// The duration, in seconds, for which the offering will reserve the node.
    duration: ?i32,

    /// The upfront fixed charge you will pay to purchase the specific reserved node
    /// offering.
    fixed_price: ?f64,

    /// The node type offered by the reserved node offering.
    node_type: ?[]const u8,

    /// The anticipated utilization of the reserved node, as defined in the reserved
    /// node
    /// offering.
    offering_type: ?[]const u8,

    /// The charge to your account regardless of whether you are creating any
    /// clusters
    /// using the node offering. Recurring charges are only in effect for
    /// heavy-utilization
    /// reserved nodes.
    recurring_charges: ?[]const RecurringCharge,

    /// The offering identifier.
    reserved_node_offering_id: ?[]const u8,

    reserved_node_offering_type: ?ReservedNodeOfferingType,

    /// The rate you are charged for each hour the cluster that is using the
    /// offering is
    /// running.
    usage_price: ?f64,
};
