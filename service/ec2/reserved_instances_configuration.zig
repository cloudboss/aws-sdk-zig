const InstanceType = @import("instance_type.zig").InstanceType;
const scope = @import("scope.zig").scope;

/// Describes the configuration settings for the modified Reserved Instances.
pub const ReservedInstancesConfiguration = struct {
    /// The Availability Zone for the modified Reserved Instances.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8,

    /// The number of modified Reserved Instances.
    ///
    /// **Note:**
    ///
    /// This is a required field for a request.
    instance_count: ?i32,

    /// The instance type for the modified Reserved Instances.
    instance_type: ?InstanceType,

    /// The network platform of the modified Reserved Instances.
    platform: ?[]const u8,

    /// Whether the Reserved Instance is applied to instances in a Region or
    /// instances in a
    /// specific Availability Zone.
    scope: ?scope,
};
