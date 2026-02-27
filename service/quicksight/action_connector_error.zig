const ActionConnectorErrorType = @import("action_connector_error_type.zig").ActionConnectorErrorType;

/// Contains error information for an action connector that is in an error
/// state.
pub const ActionConnectorError = struct {
    /// The error message describing what went wrong with the action connector.
    message: ?[]const u8,

    /// The type or category of the error.
    type: ?ActionConnectorErrorType,

    pub const json_field_names = .{
        .message = "Message",
        .type = "Type",
    };
};
