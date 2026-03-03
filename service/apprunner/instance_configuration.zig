/// Describes the runtime configuration of an App Runner service instance
/// (scaling unit).
pub const InstanceConfiguration = struct {
    /// The number of CPU units reserved for each instance of your App Runner
    /// service.
    ///
    /// Default: `1 vCPU`
    cpu: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role that provides permissions to
    /// your App Runner service. These are permissions that your code needs when it
    /// calls
    /// any Amazon Web Services APIs.
    instance_role_arn: ?[]const u8 = null,

    /// The amount of memory, in MB or GB, reserved for each instance of your App
    /// Runner service.
    ///
    /// Default: `2 GB`
    memory: ?[]const u8 = null,

    pub const json_field_names = .{
        .cpu = "Cpu",
        .instance_role_arn = "InstanceRoleArn",
        .memory = "Memory",
    };
};
