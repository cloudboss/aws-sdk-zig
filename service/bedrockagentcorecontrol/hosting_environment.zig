/// A hosting environment whose workloads are allowed to invoke the target. At
/// launch, the only supported hosting environment is AgentCore Gateway.
pub const HostingEnvironment = struct {
    /// The Amazon Resource Name (ARN) of the hosting environment.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
