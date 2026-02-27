const BillingViewStatus = @import("billing_view_status.zig").BillingViewStatus;
const BillingViewStatusReason = @import("billing_view_status_reason.zig").BillingViewStatusReason;

/// Represents the health status of a billing view, including a status code and
/// optional reasons for the status.
pub const BillingViewHealthStatus = struct {
    /// The current health status code of the billing view.
    status_code: ?BillingViewStatus,

    /// A list of reasons explaining the current health status, if applicable.
    status_reasons: ?[]const BillingViewStatusReason,

    pub const json_field_names = .{
        .status_code = "statusCode",
        .status_reasons = "statusReasons",
    };
};
