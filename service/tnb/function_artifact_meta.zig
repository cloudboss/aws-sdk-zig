const ToscaOverride = @import("tosca_override.zig").ToscaOverride;

/// Metadata for function package artifacts.
///
/// Artifacts are the contents of the package descriptor file and the state of
/// the package.
pub const FunctionArtifactMeta = struct {
    /// Lists of function package overrides.
    overrides: ?[]const ToscaOverride,

    pub const json_field_names = .{
        .overrides = "overrides",
    };
};
