const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;
const WriteOperationType = @import("write_operation_type.zig").WriteOperationType;

/// The properties that are applied when Zendesk is used as a destination.
pub const ZendeskDestinationProperties = struct {
    error_handling_config: ?ErrorHandlingConfig,

    id_field_names: ?[]const []const u8,

    /// The object specified in the Zendesk flow destination.
    object: []const u8,

    write_operation_type: ?WriteOperationType,

    pub const json_field_names = .{
        .error_handling_config = "errorHandlingConfig",
        .id_field_names = "idFieldNames",
        .object = "object",
        .write_operation_type = "writeOperationType",
    };
};
