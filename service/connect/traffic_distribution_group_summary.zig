const TrafficDistributionGroupStatus = @import("traffic_distribution_group_status.zig").TrafficDistributionGroupStatus;

/// Information about traffic distribution groups.
pub const TrafficDistributionGroupSummary = struct {
    /// The Amazon Resource Name (ARN) of the traffic distribution group.
    arn: ?[]const u8 = null,

    /// The identifier of the traffic distribution group.
    /// This can be the ID or the ARN if the API is being called in the Region where
    /// the traffic distribution group was created.
    /// The ARN must be provided if the call is from the replicated Region.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the traffic distribution group.
    instance_arn: ?[]const u8 = null,

    /// Whether this is the default traffic distribution group created during
    /// instance
    /// replication. The default traffic distribution group cannot be deleted by the
    /// `DeleteTrafficDistributionGroup` API. The default traffic distribution group
    /// is deleted as
    /// part of the process for deleting a replica.
    is_default: bool = false,

    /// The name of the traffic distribution group.
    name: ?[]const u8 = null,

    /// The status of the traffic distribution group.
    ///
    /// * `CREATION_IN_PROGRESS` means the previous
    ///   [CreateTrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateTrafficDistributionGroup.html)
    /// operation is still in progress and has not yet completed.
    ///
    /// * `ACTIVE` means the previous
    ///   [CreateTrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateTrafficDistributionGroup.html)
    /// operation has succeeded.
    ///
    /// * `CREATION_FAILED` indicates that the previous
    ///   [CreateTrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateTrafficDistributionGroup.html)
    /// operation has failed.
    ///
    /// * `PENDING_DELETION` means the previous
    ///   [DeleteTrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteTrafficDistributionGroup.html)
    /// operation is still in progress and has not yet completed.
    ///
    /// * `DELETION_FAILED` means the previous
    ///   [DeleteTrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteTrafficDistributionGroup.html)
    /// operation has failed.
    ///
    /// * `UPDATE_IN_PROGRESS` means the previous
    ///   [UpdateTrafficDistributionGroup](https://docs.aws.amazon.com/connect/latest/APIReference/API_UpdateTrafficDistributionGroup.html)
    /// operation is still in progress and has not yet completed.
    status: ?TrafficDistributionGroupStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .instance_arn = "InstanceArn",
        .is_default = "IsDefault",
        .name = "Name",
        .status = "Status",
    };
};
