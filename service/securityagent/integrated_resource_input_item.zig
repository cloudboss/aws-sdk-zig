const ProviderResourceCapabilities = @import("provider_resource_capabilities.zig").ProviderResourceCapabilities;
const IntegratedResource = @import("integrated_resource.zig").IntegratedResource;

/// Represents an input item for updating integrated resources, including the
/// resource and its capabilities.
pub const IntegratedResourceInputItem = struct {
    /// The capabilities to enable for the integrated resource.
    capabilities: ?ProviderResourceCapabilities = null,

    /// The integrated resource to update.
    resource: IntegratedResource,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .resource = "resource",
    };
};
