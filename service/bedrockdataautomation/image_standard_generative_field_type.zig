pub const ImageStandardGenerativeFieldType = enum {
    image_summary,
    iab,

    pub const json_field_names = .{
        .image_summary = "IMAGE_SUMMARY",
        .iab = "IAB",
    };
};
