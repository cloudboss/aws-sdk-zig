const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// The properties of the Amazon Web Services Glue connection.
pub const GluePropertiesOutput = struct {
    /// The error message generated if the action is not completed successfully.
    error_message: ?[]const u8 = null,

    /// The status of a connection.
    status: ?ConnectionStatus = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .status = "status",
    };
};
