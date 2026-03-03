const UsageRecordResultStatus = @import("usage_record_result_status.zig").UsageRecordResultStatus;
const UsageRecord = @import("usage_record.zig").UsageRecord;

/// A `UsageRecordResult` indicates the status of a given
/// `UsageRecord` processed by `BatchMeterUsage`.
pub const UsageRecordResult = struct {
    /// The `MeteringRecordId` is a unique identifier for this metering
    /// event.
    metering_record_id: ?[]const u8 = null,

    /// The `UsageRecordResult`
    /// `Status` indicates the status of an individual `UsageRecord`
    /// processed by `BatchMeterUsage`.
    ///
    /// * *Success*- The `UsageRecord` was accepted and
    /// honored by `BatchMeterUsage`.
    ///
    /// * *CustomerNotSubscribed*- The `CustomerIdentifier`
    /// specified is not able to use your product. The `UsageRecord` was not
    /// honored. There are three causes for this result:
    ///
    /// * The customer identifier is invalid.
    ///
    /// * The customer identifier provided in the metering record does not have
    /// an active agreement or subscription with this product. Future
    /// `UsageRecords` for this customer will fail until the
    /// customer subscribes to your product.
    ///
    /// * The customer's Amazon Web Services account was suspended.
    ///
    /// * *DuplicateRecord*- Indicates that the
    /// `UsageRecord` was invalid and not honored. A previously metered
    /// `UsageRecord` had the same customer, dimension, and time, but a
    /// different quantity.
    status: ?UsageRecordResultStatus = null,

    /// The `UsageRecord` that was part of the `BatchMeterUsage`
    /// request.
    usage_record: ?UsageRecord = null,

    pub const json_field_names = .{
        .metering_record_id = "MeteringRecordId",
        .status = "Status",
        .usage_record = "UsageRecord",
    };
};
