const aws = @import("aws");

const OrderType = @import("order_type.zig").OrderType;
const OrderStatus = @import("order_status.zig").OrderStatus;

/// A summary of line items in your order.
pub const OrderSummary = struct {
    /// The status of all line items in the order.
    line_item_counts_by_status: ?[]const aws.map.MapEntry(i32),

    /// The fulfilment date for the order.
    order_fulfilled_date: ?i64,

    /// The ID of the order.
    order_id: ?[]const u8,

    /// The submission date for the order.
    order_submission_date: ?i64,

    /// The type of order.
    order_type: ?OrderType,

    /// The ID of the Outpost.
    outpost_id: ?[]const u8,

    /// The status of the order.
    ///
    /// * `PREPARING` - Order is received and is being prepared.
    ///
    /// * `IN_PROGRESS` - Order is either being built, shipped, or installed. For
    /// more information, see the `LineItem` status.
    ///
    /// * `COMPLETED` - Order is complete.
    ///
    /// * `CANCELLED` - Order is cancelled.
    ///
    /// * `ERROR` - Customer should contact support.
    ///
    /// The following statuses are deprecated: `RECEIVED`, `PENDING`,
    /// `PROCESSING`, `INSTALLING`, and `FULFILLED`.
    status: ?OrderStatus,

    pub const json_field_names = .{
        .line_item_counts_by_status = "LineItemCountsByStatus",
        .order_fulfilled_date = "OrderFulfilledDate",
        .order_id = "OrderId",
        .order_submission_date = "OrderSubmissionDate",
        .order_type = "OrderType",
        .outpost_id = "OutpostId",
        .status = "Status",
    };
};
