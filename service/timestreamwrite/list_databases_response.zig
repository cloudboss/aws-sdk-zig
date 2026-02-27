const Database = @import("database.zig").Database;

pub const ListDatabasesResponse = struct {
    /// A list of database names.
    databases: ?[]const Database,

    /// The pagination token. This parameter is returned when the response is
    /// truncated.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .databases = "Databases",
        .next_token = "NextToken",
    };
};
