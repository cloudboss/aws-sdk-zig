/// A dataset parameter that is mapped to an analysis parameter.
pub const MappedDataSetParameter = struct {
    /// A unique name that identifies a dataset within the analysis or dashboard.
    data_set_identifier: []const u8,

    /// The name of the dataset parameter.
    data_set_parameter_name: []const u8,

    pub const json_field_names = .{
        .data_set_identifier = "DataSetIdentifier",
        .data_set_parameter_name = "DataSetParameterName",
    };
};
