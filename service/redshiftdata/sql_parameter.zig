/// A parameter used in a SQL statement.
pub const SqlParameter = struct {
    /// The name of the parameter.
    name: []const u8,

    /// The value of the parameter. Amazon Redshift implicitly converts to the
    /// proper data type. For more information, see [Data
    /// types](https://docs.aws.amazon.com/redshift/latest/dg/c_Supported_data_types.html) in the *Amazon Redshift Database Developer Guide*.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
