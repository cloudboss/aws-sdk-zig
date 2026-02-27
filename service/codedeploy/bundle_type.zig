pub const BundleType = enum {
    tar,
    tar_g_zip,
    zip,
    yaml,
    json,

    pub const json_field_names = .{
        .tar = "Tar",
        .tar_g_zip = "TarGZip",
        .zip = "Zip",
        .yaml = "YAML",
        .json = "JSON",
    };
};
