pub const ViewType = enum {
    new_image,
    old_image,
    keys_only,
    new_and_old_images,

    pub const json_field_names = .{
        .new_image = "NEW_IMAGE",
        .old_image = "OLD_IMAGE",
        .keys_only = "KEYS_ONLY",
        .new_and_old_images = "NEW_AND_OLD_IMAGES",
    };
};
