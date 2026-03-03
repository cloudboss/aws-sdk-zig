const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The current state of an impacted resource.
pub const ResourceState = struct {
    /// Shows the current lifecycle policy action that was applied to an impacted
    /// resource.
    status: ?ResourceStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
