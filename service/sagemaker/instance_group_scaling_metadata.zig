/// Metadata information about scaling operations for an instance group.
pub const InstanceGroupScalingMetadata = struct {
    /// An error message describing why the scaling operation failed, if applicable.
    failure_message: ?[]const u8,

    /// The current number of instances in the group.
    instance_count: ?i32,

    /// Minimum instance count of the instance group.
    min_count: ?i32,

    /// The desired number of instances for the group after scaling.
    target_count: ?i32,

    pub const json_field_names = .{
        .failure_message = "FailureMessage",
        .instance_count = "InstanceCount",
        .min_count = "MinCount",
        .target_count = "TargetCount",
    };
};
