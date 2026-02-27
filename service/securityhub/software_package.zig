/// Information about a software package.
pub const SoftwarePackage = struct {
    /// The architecture used for the software package.
    architecture: ?[]const u8,

    /// The epoch of the software package.
    epoch: ?[]const u8,

    /// The file system path to the package manager inventory file.
    file_path: ?[]const u8,

    /// The version of the software package in which the vulnerability has been
    /// resolved.
    fixed_in_version: ?[]const u8,

    /// The name of the software package.
    name: ?[]const u8,

    /// The source of the package.
    package_manager: ?[]const u8,

    /// The release of the software package.
    release: ?[]const u8,

    /// Describes the actions a customer can take to resolve the vulnerability in
    /// the software package.
    remediation: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the source layer.
    source_layer_arn: ?[]const u8,

    /// The source layer hash of the vulnerable package.
    source_layer_hash: ?[]const u8,

    /// The version of the software package.
    version: ?[]const u8,

    pub const json_field_names = .{
        .architecture = "Architecture",
        .epoch = "Epoch",
        .file_path = "FilePath",
        .fixed_in_version = "FixedInVersion",
        .name = "Name",
        .package_manager = "PackageManager",
        .release = "Release",
        .remediation = "Remediation",
        .source_layer_arn = "SourceLayerArn",
        .source_layer_hash = "SourceLayerHash",
        .version = "Version",
    };
};
