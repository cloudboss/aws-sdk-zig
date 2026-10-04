const CodeConfig = @import("code_config.zig").CodeConfig;
const RuntimeConfig = @import("runtime_config.zig").RuntimeConfig;

/// The build configuration for a web function revision, including code location
/// and runtime settings.
pub const BuildConfig = struct {
    /// The code configuration specifying where the deployment artifact is stored.
    code_config: CodeConfig,

    /// The runtime configuration for the revision.
    runtime_config: RuntimeConfig,

    pub const json_field_names = .{
        .code_config = "codeConfig",
        .runtime_config = "runtimeConfig",
    };
};
