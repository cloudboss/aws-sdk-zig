/// Configuration for Azure subscription integration.
pub const AzureConfiguration = struct {
    /// Azure subscription ID corresponding to provided resources.
    subscription_id: []const u8,

    pub const json_field_names = .{
        .subscription_id = "subscriptionId",
    };
};
