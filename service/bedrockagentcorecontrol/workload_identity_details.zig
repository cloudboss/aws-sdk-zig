/// The information about the workload identity.
pub const WorkloadIdentityDetails = struct {
    /// The ARN associated with the workload identity.
    workload_identity_arn: []const u8,

    pub const json_field_names = .{
        .workload_identity_arn = "workloadIdentityArn",
    };
};
