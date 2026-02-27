/// The options to configure an upsert operation when writing to a Redshift
/// target .
pub const UpsertRedshiftTargetOptions = struct {
    /// The name of the connection to use to write to Redshift.
    connection_name: ?[]const u8,

    /// The physical location of the Redshift table.
    table_location: ?[]const u8,

    /// The keys used to determine whether to perform an update or insert.
    upsert_keys: ?[]const []const u8,

    pub const json_field_names = .{
        .connection_name = "ConnectionName",
        .table_location = "TableLocation",
        .upsert_keys = "UpsertKeys",
    };
};
