const PackageConfig = @import("package_config.zig").PackageConfig;

/// The environment configuration for a notebook run in Amazon DataZone.
pub const EnvironmentConfig = struct {
    /// The image version for the notebook run environment.
    image_version: ?[]const u8 = null,

    /// The package configuration for the notebook run environment.
    package_config: ?PackageConfig = null,

    pub const json_field_names = .{
        .image_version = "imageVersion",
        .package_config = "packageConfig",
    };
};
