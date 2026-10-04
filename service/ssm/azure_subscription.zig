/// Information about an Azure subscription targeted by the cloud connector.
pub const AzureSubscription = struct {
    /// The display name of the Azure subscription.
    display_name: ?[]const u8 = null,

    /// The ID of the Azure subscription.
    id: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .id = "Id",
    };
};
