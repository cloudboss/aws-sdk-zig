const MoveStatus = @import("move_status.zig").MoveStatus;

/// **Note:**
///
/// This action is deprecated.
///
/// Describes the status of a moving Elastic IP address.
pub const MovingAddressStatus = struct {
    /// The status of the Elastic IP address that's being moved or restored.
    move_status: ?MoveStatus,

    /// The Elastic IP address.
    public_ip: ?[]const u8,
};
