pub const ModelModality = enum {
    text,
    image,
    embedding,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
        .embedding = "EMBEDDING",
    };
};
