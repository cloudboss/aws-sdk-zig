const LineItem = @import("line_item.zig").LineItem;
const OrderType = @import("order_type.zig").OrderType;
const PaymentOption = @import("payment_option.zig").PaymentOption;
const PaymentTerm = @import("payment_term.zig").PaymentTerm;
const OrderStatus = @import("order_status.zig").OrderStatus;

/// Information about an order.
pub const Order = struct {
    /// The line items for the order
    line_items: ?[]const LineItem = null,

    /// The fulfillment date of the order.
    order_fulfilled_date: ?i64 = null,

    /// The ID of the order.
    order_id: ?[]const u8 = null,

    /// The submission date for the order.
    order_submission_date: ?i64 = null,

    /// The type of order.
    order_type: ?OrderType = null,

    /// The ID of the Outpost in the order.
    outpost_id: ?[]const u8 = null,

    /// The payment option for the order.
    payment_option: ?PaymentOption = null,

    /// The payment term.
    payment_term: ?PaymentTerm = null,

    /// The status of the order.
    ///
    /// * `PREPARING` - Order is received and being prepared.
    ///
    /// * `IN_PROGRESS` - Order is either being built or shipped. To get more
    /// details, see the line item status.
    ///
    /// * `DELIVERED` - Order was delivered to the Outpost site.
    ///
    /// * `COMPLETED` - Order is complete.
    ///
    /// * `CANCELLED` - Order is cancelled.
    ///
    /// * `ERROR` - Customer should contact support.
    ///
    /// The following status are deprecated: `RECEIVED`, `PENDING`,
    /// `PROCESSING`, `INSTALLING`, and `FULFILLED`.
    status: ?OrderStatus = null,

    pub const json_field_names = .{
        .line_items = "LineItems",
        .order_fulfilled_date = "OrderFulfilledDate",
        .order_id = "OrderId",
        .order_submission_date = "OrderSubmissionDate",
        .order_type = "OrderType",
        .outpost_id = "OutpostId",
        .payment_option = "PaymentOption",
        .payment_term = "PaymentTerm",
        .status = "Status",
    };
};
