/// Metadata for a service workflow updated event.
pub const ServiceWorkflowUpdatedMetadata = struct {
    /// The identifier of the service function.
    service_function_id: ?[]const u8 = null,

    /// The name of the service function.
    service_function_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_function_id = "serviceFunctionId",
        .service_function_name = "serviceFunctionName",
    };
};
