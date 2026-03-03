const EngineType = @import("engine_type.zig").EngineType;

/// Information about an OpenSearch Service domain.
pub const DomainInfo = struct {
    /// Name of the domain.
    domain_name: ?[]const u8 = null,

    /// The type of search engine that the domain is running.`OpenSearch` for an
    /// OpenSearch engine, or `Elasticsearch` for a legacy Elasticsearch OSS
    /// engine.
    engine_type: ?EngineType = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .engine_type = "EngineType",
    };
};
