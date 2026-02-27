/// Contains information about a workload identity.
pub const WorkloadIdentityType = struct {
    /// The name of the workload identity.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the workload identity.
    workload_identity_arn: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .workload_identity_arn = "workloadIdentityArn",
    };
};
