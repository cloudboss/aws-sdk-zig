const aws = @import("aws");

const DataType = @import("data_type.zig").DataType;
const DataValue = @import("data_value.zig").DataValue;

/// An object that sets information about a property.
pub const PropertyDefinitionRequest = struct {
    /// A mapping that specifies configuration information about the property. Use
    /// this field to
    /// specify information that you read from and write to an external source.
    configuration: ?[]const aws.map.StringMapEntry = null,

    /// An object that contains information about the data type.
    data_type: ?DataType = null,

    /// An object that contains the default value.
    default_value: ?DataValue = null,

    /// A friendly name for the property.
    display_name: ?[]const u8 = null,

    /// A Boolean value that specifies whether the property ID comes from an
    /// external data
    /// store.
    is_external_id: ?bool = null,

    /// A Boolean value that specifies whether the property is required.
    is_required_in_entity: ?bool = null,

    /// A Boolean value that specifies whether the property is stored externally.
    is_stored_externally: ?bool = null,

    /// A Boolean value that specifies whether the property consists of time series
    /// data.
    is_time_series: ?bool = null,

    pub const json_field_names = .{
        .configuration = "configuration",
        .data_type = "dataType",
        .default_value = "defaultValue",
        .display_name = "displayName",
        .is_external_id = "isExternalId",
        .is_required_in_entity = "isRequiredInEntity",
        .is_stored_externally = "isStoredExternally",
        .is_time_series = "isTimeSeries",
    };
};
