const AccountTakeoverActionType = @import("account_takeover_action_type.zig").AccountTakeoverActionType;

/// A list of account-takeover actions for each level of risk that Amazon
/// Cognito might assess with
/// threat protection features.
pub const AccountTakeoverActionsType = struct {
    /// The action that you assign to a high-risk assessment by threat protection.
    high_action: ?AccountTakeoverActionType,

    /// The action that you assign to a low-risk assessment by threat protection.
    low_action: ?AccountTakeoverActionType,

    /// The action that you assign to a medium-risk assessment by threat protection.
    medium_action: ?AccountTakeoverActionType,

    pub const json_field_names = .{
        .high_action = "HighAction",
        .low_action = "LowAction",
        .medium_action = "MediumAction",
    };
};
