const Configuration = @import("configuration.zig").Configuration;
const ReconfigurationType = @import("reconfiguration_type.zig").ReconfigurationType;
const ShrinkPolicy = @import("shrink_policy.zig").ShrinkPolicy;

/// Modify the size or configurations of an instance group.
pub const InstanceGroupModifyConfig = struct {
    /// A list of new or modified configurations to apply for an instance group.
    configurations: ?[]const Configuration,

    /// The Amazon EC2 InstanceIds to terminate. After you terminate the instances,
    /// the
    /// instance group will not return to its original requested size.
    ec2_instance_ids_to_terminate: ?[]const []const u8,

    /// Target size for the instance group.
    instance_count: ?i32,

    /// Unique ID of the instance group to modify.
    instance_group_id: []const u8,

    /// Type of reconfiguration requested. Valid values are MERGE and OVERWRITE.
    reconfiguration_type: ?ReconfigurationType,

    /// Policy for customizing shrink operations.
    shrink_policy: ?ShrinkPolicy,

    pub const json_field_names = .{
        .configurations = "Configurations",
        .ec2_instance_ids_to_terminate = "EC2InstanceIdsToTerminate",
        .instance_count = "InstanceCount",
        .instance_group_id = "InstanceGroupId",
        .reconfiguration_type = "ReconfigurationType",
        .shrink_policy = "ShrinkPolicy",
    };
};
