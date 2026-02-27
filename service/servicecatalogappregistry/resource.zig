const ResourceIntegrations = @import("resource_integrations.zig").ResourceIntegrations;

/// The information about the resource.
pub const Resource = struct {
    /// The Amazon resource name (ARN) of the resource.
    arn: ?[]const u8,

    /// The time the resource was associated with the application.
    association_time: ?i64,

    /// The service integration information about the resource.
    integrations: ?ResourceIntegrations,

    /// The name of the resource.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .association_time = "associationTime",
        .integrations = "integrations",
        .name = "name",
    };
};
