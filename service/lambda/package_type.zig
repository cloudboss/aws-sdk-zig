pub const PackageType = enum {
    zip,
    image,

    pub const json_field_names = .{
        .zip = "Zip",
        .image = "Image",
    };
};
