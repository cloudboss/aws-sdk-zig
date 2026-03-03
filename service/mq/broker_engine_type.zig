const EngineType = @import("engine_type.zig").EngineType;
const EngineVersion = @import("engine_version.zig").EngineVersion;

/// Types of broker engines.
pub const BrokerEngineType = struct {
    /// The broker's engine type.
    engine_type: ?EngineType = null,

    /// The list of engine versions.
    engine_versions: ?[]const EngineVersion = null,

    pub const json_field_names = .{
        .engine_type = "EngineType",
        .engine_versions = "EngineVersions",
    };
};
