pub const ZipClassificationCode = enum {
    military,
    post_office_boxes,
    unique,

    pub const json_field_names = .{
        .military = "MILITARY",
        .post_office_boxes = "POST_OFFICE_BOXES",
        .unique = "UNIQUE",
    };
};
