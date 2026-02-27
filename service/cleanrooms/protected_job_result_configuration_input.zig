const ProtectedJobOutputConfigurationInput = @import("protected_job_output_configuration_input.zig").ProtectedJobOutputConfigurationInput;

/// The protected job result configuration input.
pub const ProtectedJobResultConfigurationInput = struct {
    /// The output configuration for a protected job result.
    output_configuration: ProtectedJobOutputConfigurationInput,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
    };
};
