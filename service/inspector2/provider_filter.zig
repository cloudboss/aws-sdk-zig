const ProviderComparison = @import("provider_comparison.zig").ProviderComparison;
const ConnectorCloudProvider = @import("connector_cloud_provider.zig").ConnectorCloudProvider;

/// A filter that matches connectors by cloud provider.
pub const ProviderFilter = struct {
    /// The comparison operator for the provider filter.
    comparison: ProviderComparison,

    /// The cloud provider value to filter by.
    value: ConnectorCloudProvider,

    pub const json_field_names = .{
        .comparison = "comparison",
        .value = "value",
    };
};
