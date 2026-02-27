const ProtectedJobS3OutputConfigurationInput = @import("protected_job_s3_output_configuration_input.zig").ProtectedJobS3OutputConfigurationInput;

/// Contains configurations for protected job results.
pub const MembershipProtectedJobOutputConfiguration = union(enum) {
    /// Contains the configuration to write the job results to S3.
    s_3: ?ProtectedJobS3OutputConfigurationInput,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
