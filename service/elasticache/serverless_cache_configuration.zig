/// The configuration settings for a specific serverless cache.
pub const ServerlessCacheConfiguration = struct {
    /// The engine that the serverless cache is configured with.
    engine: ?[]const u8,

    /// The engine version number that the serverless cache is configured with.
    major_engine_version: ?[]const u8,

    /// The identifier of a serverless cache.
    serverless_cache_name: ?[]const u8,
};
