pub const PackageType = enum {
    txt_dictionary,
    zip_plugin,
    package_license,
    package_config,

    pub const json_field_names = .{
        .txt_dictionary = "TXT_DICTIONARY",
        .zip_plugin = "ZIP_PLUGIN",
        .package_license = "PACKAGE_LICENSE",
        .package_config = "PACKAGE_CONFIG",
    };
};
