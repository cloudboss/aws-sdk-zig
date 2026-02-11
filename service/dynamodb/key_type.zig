pub const KeyType = enum {
    hash,
    range,

    pub const json_field_names = .{
        .hash = "HASH",
        .range = "RANGE",
    };
};
