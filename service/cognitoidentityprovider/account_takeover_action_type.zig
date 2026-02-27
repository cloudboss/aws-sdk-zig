const AccountTakeoverEventActionType = @import("account_takeover_event_action_type.zig").AccountTakeoverEventActionType;

/// The automated response to a risk level for adaptive authentication in
/// full-function,
/// or `ENFORCED`, mode. You can assign an action to each risk level that threat
/// protection evaluates.
pub const AccountTakeoverActionType = struct {
    /// The action to take for the attempted account takeover action for the
    /// associated risk
    /// level. Valid values are as follows:
    ///
    /// * `BLOCK`: Block the request.
    ///
    /// * `MFA_IF_CONFIGURED`: Present an MFA challenge if possible. MFA is
    /// possible if the user pool has active MFA methods that the user can set up.
    /// For
    /// example, if the user pool only supports SMS message MFA but the user
    /// doesn't have a phone number attribute, MFA setup isn't possible. If MFA
    /// setup isn't possible, allow the request.
    ///
    /// * `MFA_REQUIRED`: Present an MFA challenge if possible. Block the
    /// request if a user hasn't set up MFA. To sign in with required MFA, users
    /// must
    /// have an email address or phone number attribute, or a registered TOTP
    /// factor.
    ///
    /// * `NO_ACTION`: Take no action. Permit sign-in.
    event_action: AccountTakeoverEventActionType,

    /// Determines whether Amazon Cognito sends a user a notification message when
    /// your user pools
    /// assesses a user's session at the associated risk level.
    notify: bool = false,

    pub const json_field_names = .{
        .event_action = "EventAction",
        .notify = "Notify",
    };
};
