const ProtectedJobMemberOutputConfigurationOutput = @import("protected_job_member_output_configuration_output.zig").ProtectedJobMemberOutputConfigurationOutput;
const ProtectedJobS3OutputConfigurationOutput = @import("protected_job_s3_output_configuration_output.zig").ProtectedJobS3OutputConfigurationOutput;

/// The protected job output configuration output.
pub const ProtectedJobOutputConfigurationOutput = union(enum) {
    /// The member output configuration for a protected job.
    member: ?ProtectedJobMemberOutputConfigurationOutput,
    /// If present, the output for a protected job with an `S3` output type.
    s_3: ?ProtectedJobS3OutputConfigurationOutput,

    pub const json_field_names = .{
        .member = "member",
        .s_3 = "s3",
    };
};
