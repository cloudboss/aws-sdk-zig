/// The image type is the type of AppStream image resource.
pub const ImageType = enum {
    custom,
    native,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .native = "NATIVE",
    };
};
