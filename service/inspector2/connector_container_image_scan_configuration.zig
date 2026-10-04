const ContainerImagePullDateRescanDuration = @import("container_image_pull_date_rescan_duration.zig").ContainerImagePullDateRescanDuration;
const ContainerImageRescanDuration = @import("container_image_rescan_duration.zig").ContainerImageRescanDuration;

/// The container image scanning settings for a connector, including how long
/// pushed and pulled images continue to be rescanned for vulnerabilities.
pub const ConnectorContainerImageScanConfiguration = struct {
    /// The amount of time after a container image is last pulled from a repository
    /// during which Amazon Inspector continues to rescan the image for
    /// vulnerabilities. Valid values are `DAYS_3`, `DAYS_7`, `DAYS_14`, `DAYS_30`,
    /// `DAYS_60`, `DAYS_90`, and `DAYS_180`.
    pull_duration: ?ContainerImagePullDateRescanDuration = null,

    /// The amount of time after a container image is pushed to a repository during
    /// which Amazon Inspector continues to rescan the image for vulnerabilities.
    /// Valid values are `LIFETIME`, `DAYS_3`, `DAYS_7`, `DAYS_14`, `DAYS_30`,
    /// `DAYS_60`, `DAYS_90`, and `DAYS_180`.
    push_duration: ?ContainerImageRescanDuration = null,

    pub const json_field_names = .{
        .pull_duration = "pullDuration",
        .push_duration = "pushDuration",
    };
};
