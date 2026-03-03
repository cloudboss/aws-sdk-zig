const ImageMetadata = @import("image_metadata.zig").ImageMetadata;
const InstanceType = @import("instance_type.zig").InstanceType;
const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const InstanceState = @import("instance_state.zig").InstanceState;
const Tag = @import("tag.zig").Tag;

/// Information about the instance and the AMI used to launch the instance.
pub const InstanceImageMetadata = struct {
    /// The Availability Zone or Local Zone of the instance.
    availability_zone: ?[]const u8 = null,

    /// Information about the AMI used to launch the instance.
    image_metadata: ?ImageMetadata = null,

    /// The ID of the instance.
    instance_id: ?[]const u8 = null,

    /// The instance type.
    instance_type: ?InstanceType = null,

    /// The time the instance was launched.
    launch_time: ?i64 = null,

    /// The entity that manages the instance.
    operator: ?OperatorResponse = null,

    /// The ID of the Amazon Web Services account that owns the instance.
    owner_id: ?[]const u8 = null,

    /// The current state of the instance.
    state: ?InstanceState = null,

    /// Any tags assigned to the instance.
    tags: ?[]const Tag = null,

    /// The ID of the Availability Zone or Local Zone of the instance.
    zone_id: ?[]const u8 = null,
};
