/// Contains information about a column that stores your data.
pub const Column = struct {
    /// The name of the column.
    name: []const u8,

    /// The type of data. For more information about the supported data types, see
    /// [Common data
    /// types](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-api-common.html)
    /// in the *Glue Developer Guide*.
    type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
