const ResourceGroup = @import("resource_group.zig").ResourceGroup;

/// The service integration information about the resource.
pub const ResourceIntegrations = struct {
    /// The information about the integration of Resource Groups.
    resource_group: ?ResourceGroup,

    pub const json_field_names = .{
        .resource_group = "resourceGroup",
    };
};
