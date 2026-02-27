pub const SlotValueResolutionStrategy = enum {
    original_value,
    top_resolution,
    concatenation,

    pub const json_field_names = .{
        .original_value = "OriginalValue",
        .top_resolution = "TopResolution",
        .concatenation = "Concatenation",
    };
};
