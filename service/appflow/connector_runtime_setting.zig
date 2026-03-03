/// Contains information about the connector runtime settings that are required
/// for flow
/// execution.
pub const ConnectorRuntimeSetting = struct {
    /// Contains default values for the connector runtime setting that are supplied
    /// by the
    /// connector.
    connector_supplied_value_options: ?[]const []const u8 = null,

    /// Data type of the connector runtime setting.
    data_type: ?[]const u8 = null,

    /// A description about the connector runtime setting.
    description: ?[]const u8 = null,

    /// Indicates whether this connector runtime setting is required.
    is_required: bool = false,

    /// Contains value information about the connector runtime setting.
    key: ?[]const u8 = null,

    /// A label used for connector runtime setting.
    label: ?[]const u8 = null,

    /// Indicates the scope of the connector runtime setting.
    scope: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_supplied_value_options = "connectorSuppliedValueOptions",
        .data_type = "dataType",
        .description = "description",
        .is_required = "isRequired",
        .key = "key",
        .label = "label",
        .scope = "scope",
    };
};
