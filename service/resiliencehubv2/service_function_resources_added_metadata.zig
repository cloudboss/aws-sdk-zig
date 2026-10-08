/// Metadata for a service function resources added event.
pub const ServiceFunctionResourcesAddedMetadata = struct {
    /// The list of resource ARNs that were added.
    resources_added: ?[]const []const u8 = null,

    /// The identifier of the service function.
    service_function_id: ?[]const u8 = null,

    /// The name of the service function.
    service_function_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .resources_added = "resourcesAdded",
        .service_function_id = "serviceFunctionId",
        .service_function_name = "serviceFunctionName",
    };
};
