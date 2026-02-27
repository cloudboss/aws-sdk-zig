pub const StreamViewType = enum {
    new_image,
    old_image,
    new_and_old_images,
    keys_only,

    pub const json_field_names = .{
        .new_image = "NEW_IMAGE",
        .old_image = "OLD_IMAGE",
        .new_and_old_images = "NEW_AND_OLD_IMAGES",
        .keys_only = "KEYS_ONLY",
    };
};
