/// Defines a field to query for your application's Amazon CloudWatch Internet
/// Monitor data. You create a data repository by running a query of a specific
/// type. Each `QueryType` includes a specific set of fields and datatypes to
/// retrieve data for.
pub const QueryField = struct {
    /// The name of a field to query your application's Amazon CloudWatch Internet
    /// Monitor data for, such as `availability_score`.
    name: ?[]const u8,

    /// The data type for a query field, which must correspond to the field you're
    /// defining for `QueryField`. For example, if the query
    /// field name is `availability_score`, the data type is `float`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
