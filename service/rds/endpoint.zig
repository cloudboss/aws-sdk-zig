/// This data type represents the information you need to connect to an Amazon
/// RDS DB instance. This data type is used as a response element in the
/// following actions:
///
/// * `CreateDBInstance`
/// * `DescribeDBInstances`
/// * `DeleteDBInstance`
///
/// For the data structure that represents Amazon Aurora DB cluster endpoints,
/// see `DBClusterEndpoint`.
pub const Endpoint = struct {
    /// Specifies the DNS address of the DB instance.
    address: ?[]const u8,

    /// Specifies the ID that Amazon Route 53 assigns when you create a hosted zone.
    hosted_zone_id: ?[]const u8,

    /// Specifies the port that the database engine is listening on.
    port: ?i32,
};
