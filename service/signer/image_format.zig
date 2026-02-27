pub const ImageFormat = enum {
    json,
    json_embedded,
    json_detached,

    pub const json_field_names = .{
        .json = "JSON",
        .json_embedded = "JSONEmbedded",
        .json_detached = "JSONDetached",
    };
};
