const DeleteFleetError = @import("delete_fleet_error.zig").DeleteFleetError;

/// Describes an EC2 Fleet that was not successfully deleted.
pub const DeleteFleetErrorItem = struct {
    /// The error.
    @"error": ?DeleteFleetError = null,

    /// The ID of the EC2 Fleet.
    fleet_id: ?[]const u8 = null,
};
