const ToscaOverride = @import("tosca_override.zig").ToscaOverride;

/// Metadata for network package artifacts.
///
/// Artifacts are the contents of the package descriptor file and the state of
/// the package.
pub const NetworkArtifactMeta = struct {
    /// Lists network package overrides.
    overrides: ?[]const ToscaOverride = null,

    pub const json_field_names = .{
        .overrides = "overrides",
    };
};
