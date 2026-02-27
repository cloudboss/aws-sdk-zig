const SupportedEngineLifecycle = @import("supported_engine_lifecycle.zig").SupportedEngineLifecycle;

/// This data type is used as a response element in the operation
/// `DescribeDBMajorEngineVersions`.
pub const DBMajorEngineVersion = struct {
    /// The name of the database engine.
    engine: ?[]const u8,

    /// The major version number of the database engine.
    major_engine_version: ?[]const u8,

    /// A list of the lifecycles supported by this engine for the
    /// `DescribeDBMajorEngineVersions` operation.
    supported_engine_lifecycles: ?[]const SupportedEngineLifecycle,
};
