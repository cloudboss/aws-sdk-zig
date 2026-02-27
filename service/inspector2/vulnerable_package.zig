const PackageManager = @import("package_manager.zig").PackageManager;

/// Information on the vulnerable package identified by a finding.
pub const VulnerablePackage = struct {
    /// The architecture of the vulnerable package.
    arch: ?[]const u8,

    /// The epoch of the vulnerable package.
    epoch: i32 = 0,

    /// The file path of the vulnerable package.
    file_path: ?[]const u8,

    /// The version of the package that contains the vulnerability fix.
    fixed_in_version: ?[]const u8,

    /// The name of the vulnerable package.
    name: []const u8,

    /// The package manager of the vulnerable package.
    package_manager: ?PackageManager,

    /// The release of the vulnerable package.
    release: ?[]const u8,

    /// The code to run in your environment to update packages with a fix available.
    remediation: ?[]const u8,

    /// The Amazon Resource Number (ARN) of the Amazon Web Services Lambda function
    /// affected by a
    /// finding.
    source_lambda_layer_arn: ?[]const u8,

    /// The source layer hash of the vulnerable package.
    source_layer_hash: ?[]const u8,

    /// The version of the vulnerable package.
    version: []const u8,

    pub const json_field_names = .{
        .arch = "arch",
        .epoch = "epoch",
        .file_path = "filePath",
        .fixed_in_version = "fixedInVersion",
        .name = "name",
        .package_manager = "packageManager",
        .release = "release",
        .remediation = "remediation",
        .source_lambda_layer_arn = "sourceLambdaLayerArn",
        .source_layer_hash = "sourceLayerHash",
        .version = "version",
    };
};
