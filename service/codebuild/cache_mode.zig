pub const CacheMode = enum {
    local_docker_layer_cache,
    local_source_cache,
    local_custom_cache,

    pub const json_field_names = .{
        .local_docker_layer_cache = "LOCAL_DOCKER_LAYER_CACHE",
        .local_source_cache = "LOCAL_SOURCE_CACHE",
        .local_custom_cache = "LOCAL_CUSTOM_CACHE",
    };
};
