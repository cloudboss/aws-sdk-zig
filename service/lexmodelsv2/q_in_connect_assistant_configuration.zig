/// The configuration details of the Qinconnect assistant.
pub const QInConnectAssistantConfiguration = struct {
    /// The assistant Arn details of the Qinconnect assistant configuration.
    assistant_arn: []const u8,

    pub const json_field_names = .{
        .assistant_arn = "assistantArn",
    };
};
