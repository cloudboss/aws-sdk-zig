const CapacityBlockExtensionStatus = @import("capacity_block_extension_status.zig").CapacityBlockExtensionStatus;

/// Describes a Capacity Block extension. With an extension, you can extend the
/// duration
/// of time for an existing Capacity Block.
pub const CapacityBlockExtension = struct {
    /// The Availability Zone of the Capacity Block extension.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID of the Capacity Block extension.
    availability_zone_id: ?[]const u8 = null,

    /// The duration of the Capacity Block extension in hours.
    capacity_block_extension_duration_hours: ?i32 = null,

    /// The end date of the Capacity Block extension.
    capacity_block_extension_end_date: ?i64 = null,

    /// The ID of the Capacity Block extension offering.
    capacity_block_extension_offering_id: ?[]const u8 = null,

    /// The date when the Capacity Block extension was purchased.
    capacity_block_extension_purchase_date: ?i64 = null,

    /// The start date of the Capacity Block extension.
    capacity_block_extension_start_date: ?i64 = null,

    /// The status of the Capacity Block extension. A Capacity Block extension can
    /// have one of
    /// the following statuses:
    ///
    /// * `payment-pending` - The Capacity Block extension payment is
    /// processing. If your payment can't be processed within 12 hours, the Capacity
    /// Block extension is failed.
    ///
    /// * `payment-failed` - Payment for the Capacity Block extension request
    /// was not successful.
    ///
    /// * `payment-succeeded` - Payment for the Capacity Block extension
    /// request was successful. You receive an invoice that reflects the one-time
    /// upfront payment. In the invoice, you can associate the paid amount with the
    /// Capacity Block reservation ID.
    capacity_block_extension_status: ?CapacityBlockExtensionStatus = null,

    /// The reservation ID of the Capacity Block extension.
    capacity_reservation_id: ?[]const u8 = null,

    /// The currency of the payment for the Capacity Block extension.
    currency_code: ?[]const u8 = null,

    /// The number of instances in the Capacity Block extension.
    instance_count: ?i32 = null,

    /// The instance type of the Capacity Block extension.
    instance_type: ?[]const u8 = null,

    /// The total price to be paid up front.
    upfront_fee: ?[]const u8 = null,
};
