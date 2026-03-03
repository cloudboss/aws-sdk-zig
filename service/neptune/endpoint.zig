/// Specifies a connection endpoint.
///
/// For the data structure that represents Amazon Neptune DB cluster endpoints,
/// see `DBClusterEndpoint`.
pub const Endpoint = struct {
    /// Specifies the DNS address of the DB instance.
    address: ?[]const u8 = null,

    /// Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8 = null,

    /// Specifies the port that the database engine is listening on.
    port: ?i32 = null,
};
