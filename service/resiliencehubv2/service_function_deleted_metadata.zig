/// Metadata for a service function deleted event.
pub const ServiceFunctionDeletedMetadata = struct {
    /// The identifier of the deleted service function.
    service_function_id: ?[]const u8 = null,

    /// The name of the deleted service function.
    service_function_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .service_function_id = "serviceFunctionId",
        .service_function_name = "serviceFunctionName",
    };
};
