/// Metadata for a service resources associated event.
pub const ServiceResourcesAssociatedMetadata = struct {
    /// The number of resources associated.
    resource_count: ?i32 = null,

    /// The types of resources associated.
    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .resource_count = "resourceCount",
        .resource_types = "resourceTypes",
    };
};
