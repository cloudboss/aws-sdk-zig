pub const IndexType = enum {
    facet,
    field_index,

    pub const json_field_names = .{
        .facet = "FACET",
        .field_index = "FIELD_INDEX",
    };
};
