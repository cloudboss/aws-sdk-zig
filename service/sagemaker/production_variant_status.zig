const VariantStatus = @import("variant_status.zig").VariantStatus;

/// Describes the status of the production variant.
pub const ProductionVariantStatus = struct {
    /// The start time of the current status change.
    start_time: ?i64,

    /// The endpoint variant status which describes the current deployment stage
    /// status or operational status.
    ///
    /// * `Creating`: Creating inference resources for the production variant.
    /// * `Deleting`: Terminating inference resources for the production variant.
    /// * `Updating`: Updating capacity for the production variant.
    /// * `ActivatingTraffic`: Turning on traffic for the production variant.
    /// * `Baking`: Waiting period to monitor the CloudWatch alarms in the automatic
    ///   rollback configuration.
    status: VariantStatus,

    /// A message that describes the status of the production variant.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
