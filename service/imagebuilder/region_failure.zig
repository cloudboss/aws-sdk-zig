const ImageConfigurationStep = @import("image_configuration_step.zig").ImageConfigurationStep;
const RegionFailureStatus = @import("region_failure_status.zig").RegionFailureStatus;

/// Contains details about a distribution or image configuration failure for a
/// single
/// Region.
pub const RegionFailure = struct {
    /// The error message for the failure in the Region.
    error_message: ?[]const u8 = null,

    /// The image configuration step where the failure occurred. Image Builder sets
    /// this property
    /// when the failure happened during post-distribution configuration, such as
    /// launch
    /// template updates or virtual machine (VM) export. This property doesn't
    /// appear
    /// for failures that occurred while Image Builder copied the image to the
    /// Region.
    image_configuration_step: ?ImageConfigurationStep = null,

    /// The Region where the failure occurred.
    region: ?[]const u8 = null,

    /// The failure status for the Region. Indicates whether the process failed, was
    /// canceled, or timed out.
    status: ?RegionFailureStatus = null,

    /// The account ID of the account that the image was distributed to in the
    /// Region.
    target_account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .image_configuration_step = "imageConfigurationStep",
        .region = "region",
        .status = "status",
        .target_account_id = "targetAccountId",
    };
};
