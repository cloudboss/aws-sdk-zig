const ResourceStatusValue = @import("resource_status_value.zig").ResourceStatusValue;

/// A structure that identifies the current group membership status for a
/// resource. Adding
/// a resource to a resource group is performed asynchronously as a background
/// task. A
/// `PENDING` status indicates, for this resource, that the process isn't
/// completed yet.
pub const ResourceStatus = struct {
    /// The current status.
    name: ?ResourceStatusValue = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
