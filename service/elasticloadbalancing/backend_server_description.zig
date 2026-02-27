/// Information about the configuration of an EC2 instance.
pub const BackendServerDescription = struct {
    /// The port on which the EC2 instance is listening.
    instance_port: ?i32,

    /// The names of the policies enabled for the EC2 instance.
    policy_names: ?[]const []const u8,
};
