const Application = @import("application.zig").Application;
const DynamicAppProvidersEnabled = @import("dynamic_app_providers_enabled.zig").DynamicAppProvidersEnabled;
const ResourceError = @import("resource_error.zig").ResourceError;
const ImagePermissions = @import("image_permissions.zig").ImagePermissions;
const ImageSharedWithOthers = @import("image_shared_with_others.zig").ImageSharedWithOthers;
const ImageType = @import("image_type.zig").ImageType;
const LatestAppstreamAgentVersion = @import("latest_appstream_agent_version.zig").LatestAppstreamAgentVersion;
const PlatformType = @import("platform_type.zig").PlatformType;
const ImageState = @import("image_state.zig").ImageState;
const ImageStateChangeReason = @import("image_state_change_reason.zig").ImageStateChangeReason;
const VisibilityType = @import("visibility_type.zig").VisibilityType;

/// Describes an image.
pub const Image = struct {
    /// The applications associated with the image.
    applications: ?[]const Application = null,

    /// The version of the WorkSpaces Applications agent to use for instances that
    /// are launched from this image.
    appstream_agent_version: ?[]const u8 = null,

    /// The ARN of the image.
    arn: ?[]const u8 = null,

    /// The ARN of the image from which this image was created.
    base_image_arn: ?[]const u8 = null,

    /// The time the image was created.
    created_time: ?i64 = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// The image name to display.
    display_name: ?[]const u8 = null,

    /// Indicates whether dynamic app providers are enabled within an WorkSpaces
    /// Applications image or not.
    dynamic_app_providers_enabled: ?DynamicAppProvidersEnabled = null,

    /// The name of the image builder that was used to create the private image. If
    /// the image is shared, copied, or updated by using Managed Image Updates, this
    /// value is null.
    image_builder_name: ?[]const u8 = null,

    /// Indicates whether an image builder can be launched from this image.
    image_builder_supported: ?bool = null,

    /// Describes the errors that are returned when a new image can't be created.
    image_errors: ?[]const ResourceError = null,

    /// The permissions to provide to the destination AWS account for the specified
    /// image.
    image_permissions: ?ImagePermissions = null,

    /// Indicates whether the image is shared with another account ID.
    image_shared_with_others: ?ImageSharedWithOthers = null,

    /// The type of the image. Images created through AMI import have type "custom",
    /// while WorkSpaces Applications provided images have type "native". Custom
    /// images support additional instance types including GeneralPurpose,
    /// MemoryOptimized, ComputeOptimized, and Accelerated instance families.
    image_type: ?ImageType = null,

    /// Indicates whether the image is using the latest WorkSpaces Applications
    /// agent version or not.
    latest_appstream_agent_version: ?LatestAppstreamAgentVersion = null,

    /// Indicates whether the image includes license-included applications.
    managed_software_included: ?bool = null,

    /// The name of the image.
    name: []const u8,

    /// The operating system platform of the image.
    platform: ?PlatformType = null,

    /// The release date of the public base image.
    /// For private images, this date is the release date of the base image from
    /// which the image was created.
    public_base_image_released_date: ?i64 = null,

    /// The image starts in the `PENDING` state. If image creation succeeds, the
    /// state is `AVAILABLE`. If image creation fails, the state is `FAILED`.
    state: ?ImageState = null,

    /// The reason why the last state change occurred.
    state_change_reason: ?ImageStateChangeReason = null,

    /// The supported instances families that determine which image a customer can
    /// use when the customer launches a fleet or image builder. The following
    /// instances families are supported:
    ///
    /// * General Purpose
    ///
    /// * Compute Optimized
    ///
    /// * Memory Optimized
    ///
    /// * Graphics G4
    ///
    /// * Graphics G5
    ///
    /// * Graphics G6
    supported_instance_families: ?[]const []const u8 = null,

    /// Indicates whether the image is public or private.
    visibility: ?VisibilityType = null,

    pub const json_field_names = .{
        .applications = "Applications",
        .appstream_agent_version = "AppstreamAgentVersion",
        .arn = "Arn",
        .base_image_arn = "BaseImageArn",
        .created_time = "CreatedTime",
        .description = "Description",
        .display_name = "DisplayName",
        .dynamic_app_providers_enabled = "DynamicAppProvidersEnabled",
        .image_builder_name = "ImageBuilderName",
        .image_builder_supported = "ImageBuilderSupported",
        .image_errors = "ImageErrors",
        .image_permissions = "ImagePermissions",
        .image_shared_with_others = "ImageSharedWithOthers",
        .image_type = "ImageType",
        .latest_appstream_agent_version = "LatestAppstreamAgentVersion",
        .managed_software_included = "ManagedSoftwareIncluded",
        .name = "Name",
        .platform = "Platform",
        .public_base_image_released_date = "PublicBaseImageReleasedDate",
        .state = "State",
        .state_change_reason = "StateChangeReason",
        .supported_instance_families = "SupportedInstanceFamilies",
        .visibility = "Visibility",
    };
};
