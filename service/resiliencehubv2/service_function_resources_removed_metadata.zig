/// Metadata for a service function resources removed event.
pub const ServiceFunctionResourcesRemovedMetadata = struct {
    /// The list of resource ARNs that were removed.
    resources_removed: ?[]const []const u8 = null,

    /// The identifier of the service function.
    service_function_id: ?[]const u8 = null,

    /// The name of the service function.
    service_function_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .resources_removed = "resourcesRemoved",
        .service_function_id = "serviceFunctionId",
        .service_function_name = "serviceFunctionName",
    };
};
