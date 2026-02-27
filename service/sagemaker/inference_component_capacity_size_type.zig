pub const InferenceComponentCapacitySizeType = enum {
    copy_count,
    capacity_percent,

    pub const json_field_names = .{
        .copy_count = "COPY_COUNT",
        .capacity_percent = "CAPACITY_PERCENT",
    };
};
