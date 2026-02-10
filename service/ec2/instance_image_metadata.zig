const ImageMetadata = @import("image_metadata.zig").ImageMetadata;
const InstanceType = @import("instance_type.zig").InstanceType;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const InstanceState = @import("instance_state.zig").InstanceState;
const Tag = @import("tag.zig").Tag;

/// Information about the instance and the AMI used to launch the instance.
pub const InstanceImageMetadata = struct {
    /// The Availability Zone or Local Zone of the instance.
    availability_zone: ?[]const u8,

    /// Information about the AMI used to launch the instance.
    image_metadata: ?ImageMetadata,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The instance type.
    instance_type: ?InstanceType,

    /// The time the instance was launched.
    launch_time: ?i64,

    /// The entity that manages the instance.
    operator: ?OperatorResponse,

    /// The ID of the Amazon Web Services account that owns the instance.
    owner_id: ?[]const u8,

    /// The current state of the instance.
    state: ?InstanceState,

    /// Any tags assigned to the instance.
    tags: ?[]const Tag,

    /// The ID of the Availability Zone or Local Zone of the instance.
    zone_id: ?[]const u8,
};
