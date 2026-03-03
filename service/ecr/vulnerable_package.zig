/// Information on the vulnerable package identified by a finding.
pub const VulnerablePackage = struct {
    /// The architecture of the vulnerable package.
    arch: ?[]const u8 = null,

    /// The epoch of the vulnerable package.
    epoch: ?i32 = null,

    /// The file path of the vulnerable package.
    file_path: ?[]const u8 = null,

    /// The version of the package that contains the vulnerability fix.
    fixed_in_version: ?[]const u8 = null,

    /// The name of the vulnerable package.
    name: ?[]const u8 = null,

    /// The package manager of the vulnerable package.
    package_manager: ?[]const u8 = null,

    /// The release of the vulnerable package.
    release: ?[]const u8 = null,

    /// The source layer hash of the vulnerable package.
    source_layer_hash: ?[]const u8 = null,

    /// The version of the vulnerable package.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .arch = "arch",
        .epoch = "epoch",
        .file_path = "filePath",
        .fixed_in_version = "fixedInVersion",
        .name = "name",
        .package_manager = "packageManager",
        .release = "release",
        .source_layer_hash = "sourceLayerHash",
        .version = "version",
    };
};
