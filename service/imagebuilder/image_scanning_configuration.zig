const EcrConfiguration = @import("ecr_configuration.zig").EcrConfiguration;

/// Contains settings for Image Builder image resource and container image
/// scans.
pub const ImageScanningConfiguration = struct {
    /// Contains Amazon ECR settings for vulnerability scans.
    ecr_configuration: ?EcrConfiguration = null,

    /// Specifies whether Amazon Inspector scans for vulnerabilities when you create
    /// a new
    /// image, and whether Image Builder saves the findings. Amazon Inspector must
    /// be enabled in the
    /// account. Image tests must also be enabled. For AMI output, Amazon Inspector
    /// scans the
    /// test instance. For container output, Amazon Inspector scans the container
    /// image that
    /// Image Builder pushes to the Amazon ECR repository from your
    /// `ecrConfiguration`
    /// settings.
    image_scanning_enabled: ?bool = null,

    pub const json_field_names = .{
        .ecr_configuration = "ecrConfiguration",
        .image_scanning_enabled = "imageScanningEnabled",
    };
};
