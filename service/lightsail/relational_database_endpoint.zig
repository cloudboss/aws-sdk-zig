/// Describes an endpoint for a database.
pub const RelationalDatabaseEndpoint = struct {
    /// Specifies the DNS address of the database.
    address: ?[]const u8,

    /// Specifies the port that the database is listening on.
    port: ?i32,

    pub const json_field_names = .{
        .address = "address",
        .port = "port",
    };
};
