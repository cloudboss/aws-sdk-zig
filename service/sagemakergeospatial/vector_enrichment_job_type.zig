pub const VectorEnrichmentJobType = enum {
    reverse_geocoding,
    map_matching,

    pub const json_field_names = .{
        .reverse_geocoding = "REVERSE_GEOCODING",
        .map_matching = "MAP_MATCHING",
    };
};
