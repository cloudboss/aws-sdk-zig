pub const TextType = enum {
    handwriting,
    printed,

    pub const json_field_names = .{
        .handwriting = "HANDWRITING",
        .printed = "PRINTED",
    };
};
