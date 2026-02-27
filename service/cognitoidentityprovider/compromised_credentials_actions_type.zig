const CompromisedCredentialsEventActionType = @import("compromised_credentials_event_action_type.zig").CompromisedCredentialsEventActionType;

/// Settings for user pool actions when Amazon Cognito detects compromised
/// credentials with threat
/// protection in full-function `ENFORCED` mode.
pub const CompromisedCredentialsActionsType = struct {
    /// The action that Amazon Cognito takes when it detects compromised
    /// credentials.
    event_action: CompromisedCredentialsEventActionType,

    pub const json_field_names = .{
        .event_action = "EventAction",
    };
};
