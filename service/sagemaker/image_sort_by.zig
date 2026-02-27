pub const ImageSortBy = enum {
    creation_time,
    last_modified_time,
    image_name,

    pub const json_field_names = .{
        .creation_time = "CREATION_TIME",
        .last_modified_time = "LAST_MODIFIED_TIME",
        .image_name = "IMAGE_NAME",
    };
};
