const ProtectedJobOutputConfigurationOutput = @import("protected_job_output_configuration_output.zig").ProtectedJobOutputConfigurationOutput;

/// The output configuration for a protected job result.
pub const ProtectedJobResultConfigurationOutput = struct {
    /// The output configuration.
    output_configuration: ProtectedJobOutputConfigurationOutput,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
    };
};
