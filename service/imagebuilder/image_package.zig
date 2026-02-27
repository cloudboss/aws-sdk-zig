/// A software package that's installed on top of the base image to create a
/// customized image.
pub const ImagePackage = struct {
    /// The name of the package that's reported to the operating system package
    /// manager.
    package_name: ?[]const u8,

    /// The version of the package that's reported to the operating system package
    /// manager.
    package_version: ?[]const u8,

    pub const json_field_names = .{
        .package_name = "packageName",
        .package_version = "packageVersion",
    };
};
