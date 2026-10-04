const ResourceError = @import("resource_error.zig").ResourceError;
const ResourceState = @import("resource_state.zig").ResourceState;

/// Contains information about the current status of a resource.
pub const ResourceStatus = struct {
    /// Contains associated error information, if any.
    @"error": ?ResourceError = null,

    /// The current status of the resource.
    state: ?ResourceState = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
