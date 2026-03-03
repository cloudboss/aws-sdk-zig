const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;
const SuccessResponseHandlingConfig = @import("success_response_handling_config.zig").SuccessResponseHandlingConfig;
const WriteOperationType = @import("write_operation_type.zig").WriteOperationType;

/// The properties that are applied when using SAPOData as a flow destination
pub const SAPODataDestinationProperties = struct {
    error_handling_config: ?ErrorHandlingConfig = null,

    id_field_names: ?[]const []const u8 = null,

    /// The object path specified in the SAPOData flow destination.
    object_path: []const u8,

    /// Determines how Amazon AppFlow handles the success response that it gets from
    /// the
    /// connector after placing data.
    ///
    /// For example, this setting would determine where to write the response from a
    /// destination
    /// connector upon a successful insert operation.
    success_response_handling_config: ?SuccessResponseHandlingConfig = null,

    write_operation_type: ?WriteOperationType = null,

    pub const json_field_names = .{
        .error_handling_config = "errorHandlingConfig",
        .id_field_names = "idFieldNames",
        .object_path = "objectPath",
        .success_response_handling_config = "successResponseHandlingConfig",
        .write_operation_type = "writeOperationType",
    };
};
