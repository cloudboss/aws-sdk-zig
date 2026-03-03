const TablePropertyDescription = @import("table_property_description.zig").TablePropertyDescription;

/// The details for the data export table.
pub const Table = struct {
    /// The description for the table.
    description: ?[]const u8 = null,

    /// The name of the table.
    table_name: ?[]const u8 = null,

    /// The properties for the table.
    table_properties: ?[]const TablePropertyDescription = null,

    pub const json_field_names = .{
        .description = "Description",
        .table_name = "TableName",
        .table_properties = "TableProperties",
    };
};
