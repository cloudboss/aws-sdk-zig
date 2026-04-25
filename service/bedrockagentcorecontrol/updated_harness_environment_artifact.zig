const HarnessEnvironmentArtifact = @import("harness_environment_artifact.zig").HarnessEnvironmentArtifact;

/// Wrapper for updating the environment artifact configuration.
pub const UpdatedHarnessEnvironmentArtifact = struct {
    /// The updated environment artifact value, or null to clear the existing
    /// configuration.
    optional_value: ?HarnessEnvironmentArtifact = null,

    pub const json_field_names = .{
        .optional_value = "optionalValue",
    };
};
