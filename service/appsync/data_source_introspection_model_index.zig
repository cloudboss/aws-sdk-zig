/// The index that was retrieved from the introspected data.
pub const DataSourceIntrospectionModelIndex = struct {
    /// The fields of the index.
    fields: ?[]const []const u8,

    /// The name of the index.
    name: ?[]const u8,

    pub const json_field_names = .{
        .fields = "fields",
        .name = "name",
    };
};
