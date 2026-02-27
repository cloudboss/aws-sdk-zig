const PackageVersionOutputConfig = @import("package_version_output_config.zig").PackageVersionOutputConfig;

/// An output configuration for a package import job.
pub const PackageImportJobOutputConfig = struct {
    /// The package version's output configuration.
    package_version_output_config: ?PackageVersionOutputConfig,

    pub const json_field_names = .{
        .package_version_output_config = "PackageVersionOutputConfig",
    };
};
