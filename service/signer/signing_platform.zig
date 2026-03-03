const Category = @import("category.zig").Category;
const SigningConfiguration = @import("signing_configuration.zig").SigningConfiguration;
const SigningImageFormat = @import("signing_image_format.zig").SigningImageFormat;

/// Contains information about the signing configurations and parameters that
/// are used to
/// perform a code-signing job.
pub const SigningPlatform = struct {
    /// The category of a signing platform.
    category: ?Category = null,

    /// The display name of a signing platform.
    display_name: ?[]const u8 = null,

    /// The maximum size (in MB) of code that can be signed by a signing platform.
    max_size_in_mb: i32 = 0,

    /// Any partner entities linked to a signing platform.
    partner: ?[]const u8 = null,

    /// The ID of a signing platform.
    platform_id: ?[]const u8 = null,

    /// Indicates whether revocation is supported for the platform.
    revocation_supported: bool = false,

    /// The configuration of a signing platform. This includes the designated hash
    /// algorithm and
    /// encryption algorithm of a signing platform.
    signing_configuration: ?SigningConfiguration = null,

    signing_image_format: ?SigningImageFormat = null,

    /// The types of targets that can be signed by a signing platform.
    target: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "category",
        .display_name = "displayName",
        .max_size_in_mb = "maxSizeInMB",
        .partner = "partner",
        .platform_id = "platformId",
        .revocation_supported = "revocationSupported",
        .signing_configuration = "signingConfiguration",
        .signing_image_format = "signingImageFormat",
        .target = "target",
    };
};
