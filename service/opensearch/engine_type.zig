pub const EngineType = enum {
    open_search,
    elasticsearch,

    pub const json_field_names = .{
        .open_search = "OpenSearch",
        .elasticsearch = "Elasticsearch",
    };
};
