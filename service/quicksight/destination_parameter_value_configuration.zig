const CustomValuesConfiguration = @import("custom_values_configuration.zig").CustomValuesConfiguration;
const SelectAllValueOptions = @import("select_all_value_options.zig").SelectAllValueOptions;
const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The configuration of destination parameter values.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const DestinationParameterValueConfiguration = struct {
    /// The configuration of custom values for destination parameter in
    /// `DestinationParameterValueConfiguration`.
    custom_values_configuration: ?CustomValuesConfiguration,

    /// The configuration that selects all options.
    select_all_value_options: ?SelectAllValueOptions,

    source_column: ?ColumnIdentifier,

    /// The source field ID of the destination parameter.
    source_field: ?[]const u8,

    /// The source parameter name of the destination parameter.
    source_parameter_name: ?[]const u8,

    pub const json_field_names = .{
        .custom_values_configuration = "CustomValuesConfiguration",
        .select_all_value_options = "SelectAllValueOptions",
        .source_column = "SourceColumn",
        .source_field = "SourceField",
        .source_parameter_name = "SourceParameterName",
    };
};
