/// A time windows during which maintenance was deferred for an Amazon Redshift
/// cluster.
pub const AwsRedshiftClusterDeferredMaintenanceWindow = struct {
    /// The end of the time window for which maintenance was deferred.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    defer_maintenance_end_time: ?[]const u8,

    /// The identifier of the maintenance window.
    defer_maintenance_identifier: ?[]const u8,

    /// The start of the time window for which maintenance was deferred.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    defer_maintenance_start_time: ?[]const u8,

    pub const json_field_names = .{
        .defer_maintenance_end_time = "DeferMaintenanceEndTime",
        .defer_maintenance_identifier = "DeferMaintenanceIdentifier",
        .defer_maintenance_start_time = "DeferMaintenanceStartTime",
    };
};
