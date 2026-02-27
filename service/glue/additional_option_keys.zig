pub const AdditionalOptionKeys = enum {
    cache_option,
    observations_option,
    composite_option,

    pub const json_field_names = .{
        .cache_option = "CacheOption",
        .observations_option = "ObservationsOption",
        .composite_option = "CompositeOption",
    };
};
