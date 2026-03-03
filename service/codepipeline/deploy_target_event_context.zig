/// The context for the event for the deploy action.
pub const DeployTargetEventContext = struct {
    /// The context message for the event for the deploy action.
    message: ?[]const u8 = null,

    /// The command ID for the event for the deploy action.
    ssm_command_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .ssm_command_id = "ssmCommandId",
    };
};
