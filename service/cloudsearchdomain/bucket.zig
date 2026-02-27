/// A container for facet information.
pub const Bucket = struct {
    /// The number of hits that contain the facet value in the specified facet
    /// field.
    count: i64 = 0,

    /// The facet value being counted.
    value: ?[]const u8,

    pub const json_field_names = .{
        .count = "count",
        .value = "value",
    };
};
