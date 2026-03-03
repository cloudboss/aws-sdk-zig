const CommercialRegion = @import("commercial_region.zig").CommercialRegion;

/// A reference to a table within an Glue data catalog.
pub const GlueTableReference = struct {
    /// The name of the database the Glue table belongs to.
    database_name: []const u8,

    /// The Amazon Web Services Region where the Glue table is located. This
    /// parameter is required to uniquely identify and access tables across
    /// different Regions.
    region: ?CommercialRegion = null,

    /// The name of the Glue table.
    table_name: []const u8,

    pub const json_field_names = .{
        .database_name = "databaseName",
        .region = "region",
        .table_name = "tableName",
    };
};
