const UnsuccessfulItemError = @import("unsuccessful_item_error.zig").UnsuccessfulItemError;

/// Information about items that were not successfully processed in a batch
/// call.
pub const UnsuccessfulItem = struct {
    /// Information about the error.
    @"error": ?UnsuccessfulItemError = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,
};
