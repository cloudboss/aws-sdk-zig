const FastLaunchLaunchTemplateSpecificationResponse = @import("fast_launch_launch_template_specification_response.zig").FastLaunchLaunchTemplateSpecificationResponse;
const FastLaunchResourceType = @import("fast_launch_resource_type.zig").FastLaunchResourceType;
const FastLaunchSnapshotConfigurationResponse = @import("fast_launch_snapshot_configuration_response.zig").FastLaunchSnapshotConfigurationResponse;
const FastLaunchStateCode = @import("fast_launch_state_code.zig").FastLaunchStateCode;

/// Describe details about a Windows image with Windows fast launch enabled that
/// meets the
/// requested criteria. Criteria are defined by the `DescribeFastLaunchImages`
/// action
/// filters.
pub const DescribeFastLaunchImagesSuccessItem = struct {
    /// The image ID that identifies the Windows fast launch enabled image.
    image_id: ?[]const u8,

    /// The launch template that the Windows fast launch enabled AMI uses when it
    /// launches Windows
    /// instances from pre-provisioned snapshots.
    launch_template: ?FastLaunchLaunchTemplateSpecificationResponse,

    /// The maximum number of instances that Amazon EC2 can launch at the same time
    /// to create
    /// pre-provisioned snapshots for Windows fast launch.
    max_parallel_launches: ?i32,

    /// The owner ID for the Windows fast launch enabled AMI.
    owner_id: ?[]const u8,

    /// The resource type that Amazon EC2 uses for pre-provisioning the Windows AMI.
    /// Supported values
    /// include: `snapshot`.
    resource_type: ?FastLaunchResourceType,

    /// A group of parameters that are used for pre-provisioning the associated
    /// Windows AMI using
    /// snapshots.
    snapshot_configuration: ?FastLaunchSnapshotConfigurationResponse,

    /// The current state of Windows fast launch for the specified Windows AMI.
    state: ?FastLaunchStateCode,

    /// The reason that Windows fast launch for the AMI changed to the current
    /// state.
    state_transition_reason: ?[]const u8,

    /// The time that Windows fast launch for the AMI changed to the current state.
    state_transition_time: ?i64,
};
