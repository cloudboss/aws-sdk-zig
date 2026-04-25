const CommercialRegion = @import("commercial_region.zig").CommercialRegion;

/// A reference to a table within Athena.
pub const AthenaTableReference = struct {
    /// The catalog name.
    catalog_name: ?[]const u8 = null,

    /// The database name.
    database_name: []const u8,

    /// The output location for the Athena table.
    output_location: ?[]const u8 = null,

    /// The Amazon Web Services Region where the Athena table is located. This
    /// parameter is required to uniquely identify and access tables across
    /// different Regions.
    region: ?CommercialRegion = null,

    /// The table reference.
    table_name: []const u8,

    /// The workgroup of the Athena table reference.
    work_group: []const u8,

    pub const json_field_names = .{
        .catalog_name = "catalogName",
        .database_name = "databaseName",
        .output_location = "outputLocation",
        .region = "region",
        .table_name = "tableName",
        .work_group = "workGroup",
    };
};
