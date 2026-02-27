pub const SegmentType = enum {
    dimensional,
    import,

    pub const json_field_names = .{
        .dimensional = "DIMENSIONAL",
        .import = "IMPORT",
    };
};
