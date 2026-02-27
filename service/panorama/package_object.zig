/// A package object.
pub const PackageObject = struct {
    /// The object's name.
    name: []const u8,

    /// The object's package version.
    package_version: []const u8,

    /// The object's patch version.
    patch_version: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .package_version = "PackageVersion",
        .patch_version = "PatchVersion",
    };
};
