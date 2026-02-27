pub const KnowledgeBaseQueryType = enum {
    text,
    image,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
    };
};
