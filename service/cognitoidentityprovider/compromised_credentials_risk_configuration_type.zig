const CompromisedCredentialsActionsType = @import("compromised_credentials_actions_type.zig").CompromisedCredentialsActionsType;
const EventFilterType = @import("event_filter_type.zig").EventFilterType;

/// Settings for compromised-credentials actions and authentication-event
/// sources with
/// threat protection in full-function `ENFORCED` mode.
pub const CompromisedCredentialsRiskConfigurationType = struct {
    /// Settings for the actions that you want your user pool to take when Amazon
    /// Cognito detects
    /// compromised credentials.
    actions: CompromisedCredentialsActionsType,

    /// Settings for the sign-in activity where you want to configure
    /// compromised-credentials
    /// actions. Defaults to all events.
    event_filter: ?[]const EventFilterType = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .event_filter = "EventFilter",
    };
};
