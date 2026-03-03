const EnvironmentParameter = @import("environment_parameter.zig").EnvironmentParameter;

/// Defines the model configuration. Includes the specification name and
/// environment parameters.
pub const ModelConfiguration = struct {
    /// The name of the compilation job used to create the recommended model
    /// artifacts.
    compilation_job_name: ?[]const u8 = null,

    /// Defines the environment parameters that includes key, value types, and
    /// values.
    environment_parameters: ?[]const EnvironmentParameter = null,

    /// The inference specification name in the model package version.
    inference_specification_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .compilation_job_name = "CompilationJobName",
        .environment_parameters = "EnvironmentParameters",
        .inference_specification_name = "InferenceSpecificationName",
    };
};
