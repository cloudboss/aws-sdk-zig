pub const CollectionType = enum {
    list,
    set,
    vector,

    pub const json_field_names = .{
        .list = "LIST",
        .set = "SET",
        .vector = "VECTOR",
    };
};
