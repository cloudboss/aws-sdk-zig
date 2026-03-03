const PackageVersionInputConfig = @import("package_version_input_config.zig").PackageVersionInputConfig;

/// A configuration for a package import job.
pub const PackageImportJobInputConfig = struct {
    /// The package version's input configuration.
    package_version_input_config: ?PackageVersionInputConfig = null,

    pub const json_field_names = .{
        .package_version_input_config = "PackageVersionInputConfig",
    };
};
