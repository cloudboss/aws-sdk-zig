/// The profile associated with a workload.
pub const WorkloadProfile = struct {
    /// The profile ARN.
    profile_arn: ?[]const u8 = null,

    /// The profile version.
    profile_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .profile_arn = "ProfileArn",
        .profile_version = "ProfileVersion",
    };
};
