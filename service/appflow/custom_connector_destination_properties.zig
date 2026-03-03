const aws = @import("aws");

const ErrorHandlingConfig = @import("error_handling_config.zig").ErrorHandlingConfig;
const WriteOperationType = @import("write_operation_type.zig").WriteOperationType;

/// The properties that are applied when the custom connector is being used as a
/// destination.
pub const CustomConnectorDestinationProperties = struct {
    /// The custom properties that are specific to the connector when it's used as a
    /// destination
    /// in the flow.
    custom_properties: ?[]const aws.map.StringMapEntry = null,

    /// The entity specified in the custom connector as a destination in the flow.
    entity_name: []const u8,

    /// The settings that determine how Amazon AppFlow handles an error when placing
    /// data in
    /// the custom connector as destination.
    error_handling_config: ?ErrorHandlingConfig = null,

    /// The name of the field that Amazon AppFlow uses as an ID when performing a
    /// write
    /// operation such as update, delete, or upsert.
    id_field_names: ?[]const []const u8 = null,

    /// Specifies the type of write operation to be performed in the custom
    /// connector when it's
    /// used as destination.
    write_operation_type: ?WriteOperationType = null,

    pub const json_field_names = .{
        .custom_properties = "customProperties",
        .entity_name = "entityName",
        .error_handling_config = "errorHandlingConfig",
        .id_field_names = "idFieldNames",
        .write_operation_type = "writeOperationType",
    };
};
