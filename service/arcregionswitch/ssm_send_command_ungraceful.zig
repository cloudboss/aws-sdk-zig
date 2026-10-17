const SsmSendCommandUngracefulBehavior = @import("ssm_send_command_ungraceful_behavior.zig").SsmSendCommandUngracefulBehavior;

/// The ungraceful execution settings for an AWS Systems Manager `SendCommand`
/// execution block.
pub const SsmSendCommandUngraceful = struct {
    /// Specifies whether to skip running this command during an ungraceful
    /// execution. Set to `skip` to skip the command.
    behavior: ?SsmSendCommandUngracefulBehavior = null,

    pub const json_field_names = .{
        .behavior = "behavior",
    };
};
