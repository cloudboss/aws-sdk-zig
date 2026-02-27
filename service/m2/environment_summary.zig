const EngineType = @import("engine_type.zig").EngineType;
const NetworkType = @import("network_type.zig").NetworkType;
const EnvironmentLifecycle = @import("environment_lifecycle.zig").EnvironmentLifecycle;

/// Contains a subset of the possible runtime environment attributes. Used in
/// the
/// environment list.
pub const EnvironmentSummary = struct {
    /// The timestamp when the runtime environment was created.
    creation_time: i64,

    /// The target platform for the runtime environment.
    engine_type: EngineType,

    /// The version of the runtime engine.
    engine_version: []const u8,

    /// The Amazon Resource Name (ARN) of a particular runtime environment.
    environment_arn: []const u8,

    /// The unique identifier of a particular runtime environment.
    environment_id: []const u8,

    /// The instance type of the runtime environment.
    instance_type: []const u8,

    /// The name of the runtime environment.
    name: []const u8,

    /// The network type supported by the runtime environment.
    network_type: ?NetworkType,

    /// The status of the runtime environment
    status: EnvironmentLifecycle,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .engine_type = "engineType",
        .engine_version = "engineVersion",
        .environment_arn = "environmentArn",
        .environment_id = "environmentId",
        .instance_type = "instanceType",
        .name = "name",
        .network_type = "networkType",
        .status = "status",
    };
};
