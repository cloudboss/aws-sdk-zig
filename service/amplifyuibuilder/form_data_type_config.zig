const FormDataSourceType = @import("form_data_source_type.zig").FormDataSourceType;

/// Describes the data type configuration for the data source associated with a
/// form.
pub const FormDataTypeConfig = struct {
    /// The data source type, either an Amplify DataStore model or a custom data
    /// type.
    data_source_type: FormDataSourceType,

    /// The unique name of the data type you are using as the data source for the
    /// form.
    data_type_name: []const u8,

    pub const json_field_names = .{
        .data_source_type = "dataSourceType",
        .data_type_name = "dataTypeName",
    };
};
