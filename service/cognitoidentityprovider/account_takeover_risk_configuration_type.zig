const AccountTakeoverActionsType = @import("account_takeover_actions_type.zig").AccountTakeoverActionsType;
const NotifyConfigurationType = @import("notify_configuration_type.zig").NotifyConfigurationType;

/// The settings for automated responses and notification templates for adaptive
/// authentication with threat protection features.
pub const AccountTakeoverRiskConfigurationType = struct {
    /// A list of account-takeover actions for each level of risk that Amazon
    /// Cognito might assess with
    /// threat protection.
    actions: AccountTakeoverActionsType,

    /// The settings for composing and sending an email message when threat
    /// protection
    /// assesses a risk level with adaptive authentication. When you choose to
    /// notify users in
    /// `AccountTakeoverRiskConfiguration`, Amazon Cognito sends an email message
    /// using
    /// the method and template that you set with this data type.
    notify_configuration: ?NotifyConfigurationType,

    pub const json_field_names = .{
        .actions = "Actions",
        .notify_configuration = "NotifyConfiguration",
    };
};
