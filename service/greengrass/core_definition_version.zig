const Core = @import("core.zig").Core;

/// Information about a core definition version.
pub const CoreDefinitionVersion = struct {
    /// A list of cores in the core definition version.
    cores: ?[]const Core,

    pub const json_field_names = .{
        .cores = "Cores",
    };
};
