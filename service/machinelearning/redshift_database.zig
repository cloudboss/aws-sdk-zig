/// Describes the database details required to connect to an Amazon Redshift
/// database.
pub const RedshiftDatabase = struct {
    cluster_identifier: []const u8,

    database_name: []const u8,

    pub const json_field_names = .{
        .cluster_identifier = "ClusterIdentifier",
        .database_name = "DatabaseName",
    };
};
