const aws = @import("aws");

const DataTransferApi = @import("data_transfer_api.zig").DataTransferApi;

/// The properties that are applied when the custom connector is being used as a
/// source.
pub const CustomConnectorSourceProperties = struct {
    /// Custom properties that are required to use the custom connector as a source.
    custom_properties: ?[]const aws.map.StringMapEntry = null,

    /// The API of the connector application that Amazon AppFlow uses to transfer
    /// your
    /// data.
    data_transfer_api: ?DataTransferApi = null,

    /// The entity specified in the custom connector as a source in the flow.
    entity_name: []const u8,

    pub const json_field_names = .{
        .custom_properties = "customProperties",
        .data_transfer_api = "dataTransferApi",
        .entity_name = "entityName",
    };
};
