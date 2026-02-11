pub const ExportViewType = enum {
    new_image,
    new_and_old_images,

    pub const json_field_names = .{
        .new_image = "NEW_IMAGE",
        .new_and_old_images = "NEW_AND_OLD_IMAGES",
    };
};
