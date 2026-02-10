const GroupIdentifier = @import("group_identifier.zig").GroupIdentifier;
const Instance = @import("instance.zig").Instance;

/// Describes a launch request for one or more instances, and includes owner,
/// requester,
/// and security group information that applies to all instances in the launch
/// request.
pub const Reservation = struct {
    /// Not supported.
    groups: ?[]const GroupIdentifier,

    /// The instances.
    instances: ?[]const Instance,

    /// The ID of the Amazon Web Services account that owns the reservation.
    owner_id: ?[]const u8,

    /// The ID of the requester that launched the instances on your behalf (for
    /// example,
    /// Amazon Web Services Management Console or Auto Scaling).
    requester_id: ?[]const u8,

    /// The ID of the reservation.
    reservation_id: ?[]const u8,
};
