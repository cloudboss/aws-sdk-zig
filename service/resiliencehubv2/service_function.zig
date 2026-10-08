const ServiceFunctionCriticality = @import("service_function_criticality.zig").ServiceFunctionCriticality;
const ServiceFunctionSource = @import("service_function_source.zig").ServiceFunctionSource;

/// Represents a logical component of a service.
pub const ServiceFunction = struct {
    /// The timestamp when the service function was created.
    created_at: ?i64 = null,

    /// The criticality level of the service function.
    criticality: ServiceFunctionCriticality,

    description: ?[]const u8 = null,

    name: []const u8,

    /// The number of resources associated with the service function.
    resource_count: ?i32 = null,

    service_arn: []const u8,

    /// The unique identifier of the service function.
    service_function_id: []const u8,

    /// The source of the service function.
    source: ?ServiceFunctionSource = null,

    /// The timestamp when the service function was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .criticality = "criticality",
        .description = "description",
        .name = "name",
        .resource_count = "resourceCount",
        .service_arn = "serviceArn",
        .service_function_id = "serviceFunctionId",
        .source = "source",
        .updated_at = "updatedAt",
    };
};
