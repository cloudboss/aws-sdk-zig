/// The detail of the primary key field.
pub const DataLakeDatasetPrimaryKeyField = struct {
    /// The name of the primary key field.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
