const ErrorDetails = @import("error_details.zig").ErrorDetails;
const State = @import("state.zig").State;

/// An object that represents the status of an entity, component, component
/// type, or
/// workspace.
pub const Status = struct {
    /// The error message.
    @"error": ?ErrorDetails = null,

    /// The current state of the entity, component, component type, or workspace.
    state: ?State = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
