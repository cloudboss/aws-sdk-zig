const ModuleParameters = @import("module_parameters.zig").ModuleParameters;

/// Describes the configuration of a module.
pub const ModuleConfiguration = struct {
    /// The dependencies of the module.
    depends_on: ?[]const []const u8,

    /// Describes the parameters of a module.
    module_parameters: ?ModuleParameters,

    /// The name of the module.
    name: []const u8,

    /// The version of the module.
    version: ?[]const u8,

    pub const json_field_names = .{
        .depends_on = "dependsOn",
        .module_parameters = "moduleParameters",
        .name = "name",
        .version = "version",
    };
};
