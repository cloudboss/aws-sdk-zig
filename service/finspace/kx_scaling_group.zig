const KxScalingGroupStatus = @import("kx_scaling_group_status.zig").KxScalingGroupStatus;

/// A structure for storing metadata of scaling group.
pub const KxScalingGroup = struct {
    /// The identifier of the availability zones.
    availability_zone_id: ?[]const u8,

    /// The list of clusters currently active in a given scaling group.
    clusters: ?[]const []const u8,

    /// The timestamp at which the scaling group was created in FinSpace. The value
    /// is determined as epoch time in milliseconds. For example, the value for
    /// Monday, November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64,

    /// The memory and CPU capabilities of the scaling group host on which FinSpace
    /// Managed kdb clusters will be placed.
    ///
    /// You can add one of the following values:
    ///
    /// * `kx.sg.large` – The host type with a configuration of 16 GiB
    /// memory and 2 vCPUs.
    ///
    /// * `kx.sg.xlarge` – The host type with a configuration of 32 GiB
    /// memory and 4 vCPUs.
    ///
    /// * `kx.sg.2xlarge` – The host type with a configuration of 64 GiB
    /// memory and 8 vCPUs.
    ///
    /// * `kx.sg.4xlarge` – The host type with a configuration of 108 GiB memory and
    ///   16 vCPUs.
    ///
    /// * `kx.sg.8xlarge` – The host type with a configuration of 216 GiB memory and
    ///   32 vCPUs.
    ///
    /// * `kx.sg.16xlarge` – The host type with a configuration of 432 GiB memory
    ///   and 64 vCPUs.
    ///
    /// * `kx.sg.32xlarge` – The host type with a configuration of 864 GiB memory
    ///   and 128 vCPUs.
    ///
    /// * `kx.sg1.16xlarge` – The host type with a configuration of 1949 GiB memory
    ///   and 64 vCPUs.
    ///
    /// * `kx.sg1.24xlarge` – The host type with a configuration of 2948 GiB memory
    ///   and 96 vCPUs.
    host_type: ?[]const u8,

    /// The last time that the scaling group was updated in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64,

    /// A unique identifier for the kdb scaling group.
    scaling_group_name: ?[]const u8,

    /// The status of scaling groups.
    status: ?KxScalingGroupStatus,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .clusters = "clusters",
        .created_timestamp = "createdTimestamp",
        .host_type = "hostType",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .scaling_group_name = "scalingGroupName",
        .status = "status",
        .status_reason = "statusReason",
    };
};
