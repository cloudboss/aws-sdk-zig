const ResourceGroup = @import("resource_group.zig").ResourceGroup;

/// The information about the service integration.
pub const Integrations = struct {
    application_tag_resource_group: ?ResourceGroup = null,

    /// The information about the resource group integration.
    resource_group: ?ResourceGroup = null,

    pub const json_field_names = .{
        .application_tag_resource_group = "applicationTagResourceGroup",
        .resource_group = "resourceGroup",
    };
};
