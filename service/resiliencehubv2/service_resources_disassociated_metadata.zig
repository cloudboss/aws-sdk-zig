/// Metadata for a service resources disassociated event.
pub const ServiceResourcesDisassociatedMetadata = struct {
    /// The number of resources disassociated.
    resource_count: ?i32 = null,

    /// The types of resources disassociated.
    resource_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .resource_count = "resourceCount",
        .resource_types = "resourceTypes",
    };
};
