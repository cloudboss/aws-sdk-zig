const ErrorObject = @import("error_object.zig").ErrorObject;

/// Error information for an event.
pub const EventError = struct {
    /// The error payload.
    payload: ?ErrorObject,

    /// Indicates if the error payload was truncated due to size limits.
    truncated: ?bool,
};
