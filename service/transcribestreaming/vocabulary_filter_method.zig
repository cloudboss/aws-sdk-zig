pub const VocabularyFilterMethod = enum {
    remove,
    mask,
    tag,

    pub const json_field_names = .{
        .remove = "REMOVE",
        .mask = "MASK",
        .tag = "TAG",
    };
};
