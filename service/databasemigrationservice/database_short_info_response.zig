/// Describes a database in a Fleet Advisor collector inventory.
pub const DatabaseShortInfoResponse = struct {
    /// The database engine of a database in a Fleet Advisor collector inventory,
    /// for example
    /// `PostgreSQL`.
    database_engine: ?[]const u8,

    /// The ID of a database in a Fleet Advisor collector inventory.
    database_id: ?[]const u8,

    /// The IP address of a database in a Fleet Advisor collector inventory.
    database_ip_address: ?[]const u8,

    /// The name of a database in a Fleet Advisor collector inventory.
    database_name: ?[]const u8,

    pub const json_field_names = .{
        .database_engine = "DatabaseEngine",
        .database_id = "DatabaseId",
        .database_ip_address = "DatabaseIpAddress",
        .database_name = "DatabaseName",
    };
};
