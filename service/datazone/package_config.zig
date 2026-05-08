const PackageManager = @import("package_manager.zig").PackageManager;

/// The package configuration for a notebook run environment in Amazon DataZone.
pub const PackageConfig = struct {
    /// The package manager for the notebook run environment. The default value is
    /// `UV`.
    package_manager: PackageManager = .uv,

    /// The package specification content for the notebook run environment. The
    /// maximum length is 10240 characters.
    package_specification: ?[]const u8 = null,

    pub const json_field_names = .{
        .package_manager = "packageManager",
        .package_specification = "packageSpecification",
    };
};
