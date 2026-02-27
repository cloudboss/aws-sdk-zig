const QInConnectAssistantConfiguration = @import("q_in_connect_assistant_configuration.zig").QInConnectAssistantConfiguration;

/// The configuration details of the Qinconnect intent.
pub const QInConnectIntentConfiguration = struct {
    /// The Qinconnect assistant configuration details of the Qinconnect intent.
    q_in_connect_assistant_configuration: ?QInConnectAssistantConfiguration,

    pub const json_field_names = .{
        .q_in_connect_assistant_configuration = "qInConnectAssistantConfiguration",
    };
};
