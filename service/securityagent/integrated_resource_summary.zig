const ProviderResourceCapabilities = @import("provider_resource_capabilities.zig").ProviderResourceCapabilities;
const IntegratedResourceMetadata = @import("integrated_resource_metadata.zig").IntegratedResourceMetadata;

/// Contains summary information about an integrated resource.
pub const IntegratedResourceSummary = struct {
    /// The capabilities enabled for the integrated resource.
    capabilities: ?ProviderResourceCapabilities = null,

    /// The unique identifier of the integration that provides access to the
    /// resource.
    integration_id: []const u8,

    /// The metadata for the integrated resource.
    resource: IntegratedResourceMetadata,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .integration_id = "integrationId",
        .resource = "resource",
    };
};
