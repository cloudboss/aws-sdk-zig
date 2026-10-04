const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The state to apply to the image resource in a resource state update
/// request.
pub const ResourceState = struct {
    /// The status to which you want to move the image resource. Set the status to
    /// `AVAILABLE` to restore an image that's currently deprecated
    /// or disabled.
    status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
