const InstanceType = @import("instance_type.zig").InstanceType;
const LocationType = @import("location_type.zig").LocationType;

/// The instance types offered.
pub const InstanceTypeOffering = struct {
    /// The instance type. For more information, see [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html) in the *Amazon EC2
    /// User Guide*.
    instance_type: ?InstanceType,

    /// The identifier for the location. This depends on the location type. For
    /// example, if the
    /// location type is `region`, the location is the Region code (for example,
    /// `us-east-2`.)
    location: ?[]const u8,

    /// The location type.
    location_type: ?LocationType,
};
