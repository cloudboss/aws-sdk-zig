/// A software package that's installed on an image, as detected by Amazon Web
/// Services Systems Manager
/// Inventory at build time. The list includes packages that shipped with the
/// base image.
pub const ImagePackage = struct {
    /// The name of the package that's reported to the operating system package
    /// manager.
    package_name: ?[]const u8 = null,

    /// The version of the package that's reported to the operating system package
    /// manager.
    package_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .package_name = "packageName",
        .package_version = "packageVersion",
    };
};
