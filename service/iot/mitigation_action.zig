const MitigationActionParams = @import("mitigation_action_params.zig").MitigationActionParams;

/// Describes which changes should be applied as part of a mitigation action.
pub const MitigationAction = struct {
    /// The set of parameters for this mitigation action. The parameters vary,
    /// depending on the kind of action you apply.
    action_params: ?MitigationActionParams = null,

    /// A unique identifier for the mitigation action.
    id: ?[]const u8 = null,

    /// A user-friendly name for the mitigation action.
    name: ?[]const u8 = null,

    /// The IAM role ARN used to apply this mitigation action.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_params = "actionParams",
        .id = "id",
        .name = "name",
        .role_arn = "roleArn",
    };
};
