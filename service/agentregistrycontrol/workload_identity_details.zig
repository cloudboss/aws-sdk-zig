/// The workload identity details associated with a source resource. Present on
/// the source details of a provenance entry when the upstream resource has a
/// workload identity configured.
pub const WorkloadIdentityDetails = struct {
    /// The Amazon Resource Name (ARN) of the workload identity associated with the
    /// source resource.
    workload_identity_arn: []const u8,

    pub const json_field_names = .{
        .workload_identity_arn = "workloadIdentityArn",
    };
};
