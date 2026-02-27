pub const PackageType = enum {
    image,
    zip,

    pub const json_field_names = .{
        .image = "IMAGE",
        .zip = "ZIP",
    };
};
