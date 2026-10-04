const AzureSubscription = @import("azure_subscription.zig").AzureSubscription;

/// The target resources in the third-party cloud environment.
pub const ConfigurationTargets = union(enum) {
    /// A list of Azure subscriptions to target.
    subscriptions: ?[]const AzureSubscription,

    pub const json_field_names = .{
        .subscriptions = "Subscriptions",
    };
};
