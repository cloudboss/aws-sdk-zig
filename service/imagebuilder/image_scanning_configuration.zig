const EcrConfiguration = @import("ecr_configuration.zig").EcrConfiguration;

/// Contains settings for Image Builder image resource and container image
/// scans.
pub const ImageScanningConfiguration = struct {
    /// Contains Amazon ECR settings for vulnerability scans.
    ecr_configuration: ?EcrConfiguration = null,

    /// A setting that indicates whether Image Builder keeps a snapshot of the
    /// vulnerability scans that
    /// Amazon Inspector runs against the build instance when you create a new
    /// image.
    image_scanning_enabled: ?bool = null,

    pub const json_field_names = .{
        .ecr_configuration = "ecrConfiguration",
        .image_scanning_enabled = "imageScanningEnabled",
    };
};
