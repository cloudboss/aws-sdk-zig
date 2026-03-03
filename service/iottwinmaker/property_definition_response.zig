const aws = @import("aws");

const DataType = @import("data_type.zig").DataType;
const DataValue = @import("data_value.zig").DataValue;

/// An object that contains response data from a property definition request.
pub const PropertyDefinitionResponse = struct {
    /// A mapping that specifies configuration information about the property.
    configuration: ?[]const aws.map.StringMapEntry = null,

    /// An object that contains information about the data type.
    data_type: DataType,

    /// An object that contains the default value.
    default_value: ?DataValue = null,

    /// A friendly name for the property.
    display_name: ?[]const u8 = null,

    /// A Boolean value that specifies whether the property ID comes from an
    /// external data
    /// store.
    is_external_id: bool,

    /// A Boolean value that specifies whether the property definition can be
    /// updated.
    is_final: bool,

    /// A Boolean value that specifies whether the property definition is imported
    /// from an
    /// external data store.
    is_imported: bool,

    /// A Boolean value that specifies whether the property definition is inherited
    /// from a
    /// parent entity.
    is_inherited: bool,

    /// A Boolean value that specifies whether the property is required in an
    /// entity.
    is_required_in_entity: bool,

    /// A Boolean value that specifies whether the property is stored externally.
    is_stored_externally: bool,

    /// A Boolean value that specifies whether the property consists of time series
    /// data.
    is_time_series: bool,

    pub const json_field_names = .{
        .configuration = "configuration",
        .data_type = "dataType",
        .default_value = "defaultValue",
        .display_name = "displayName",
        .is_external_id = "isExternalId",
        .is_final = "isFinal",
        .is_imported = "isImported",
        .is_inherited = "isInherited",
        .is_required_in_entity = "isRequiredInEntity",
        .is_stored_externally = "isStoredExternally",
        .is_time_series = "isTimeSeries",
    };
};
