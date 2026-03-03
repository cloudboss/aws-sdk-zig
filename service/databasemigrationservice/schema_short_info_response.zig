/// Describes a schema in a Fleet Advisor collector inventory.
pub const SchemaShortInfoResponse = struct {
    /// The ID of a database in a Fleet Advisor collector inventory.
    database_id: ?[]const u8 = null,

    /// The IP address of a database in a Fleet Advisor collector inventory.
    database_ip_address: ?[]const u8 = null,

    /// The name of a database in a Fleet Advisor collector inventory.
    database_name: ?[]const u8 = null,

    /// The ID of a schema in a Fleet Advisor collector inventory.
    schema_id: ?[]const u8 = null,

    /// The name of a schema in a Fleet Advisor collector inventory.
    schema_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_id = "DatabaseId",
        .database_ip_address = "DatabaseIpAddress",
        .database_name = "DatabaseName",
        .schema_id = "SchemaId",
        .schema_name = "SchemaName",
    };
};
