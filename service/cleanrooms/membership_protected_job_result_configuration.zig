const MembershipProtectedJobOutputConfiguration = @import("membership_protected_job_output_configuration.zig").MembershipProtectedJobOutputConfiguration;

/// Contains configurations for protected job results.
pub const MembershipProtectedJobResultConfiguration = struct {
    /// The output configuration for a protected job result.
    output_configuration: MembershipProtectedJobOutputConfiguration,

    /// The unique ARN for an IAM role that is used by Clean Rooms to write
    /// protected job results to the result location, given by the member who can
    /// receive results.
    role_arn: []const u8,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
        .role_arn = "roleArn",
    };
};
