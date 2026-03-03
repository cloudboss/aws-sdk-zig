/// Launch into existing instance.
pub const LaunchIntoInstanceProperties = struct {
    /// Optionally holds EC2 instance ID of an instance to launch into, instead of
    /// launching a new instance during drill, recovery or failback.
    launch_into_ec2_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .launch_into_ec2_instance_id = "launchIntoEC2InstanceID",
    };
};
