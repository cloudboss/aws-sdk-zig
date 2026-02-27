const RuntimeName = @import("runtime_name.zig").RuntimeName;

/// Describes a runtime used by an Amazon Web Services AppSync pipeline resolver
/// or Amazon Web Services AppSync function. Specifies the name and version of
/// the runtime to use. Note
/// that if a runtime is specified, code must also be specified.
pub const AppSyncRuntime = struct {
    /// The `name` of the runtime to use. Currently, the only allowed value is
    /// `APPSYNC_JS`.
    name: RuntimeName,

    /// The `version` of the runtime to use. Currently, the only allowed version is
    /// `1.0.0`.
    runtime_version: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .runtime_version = "runtimeVersion",
    };
};
