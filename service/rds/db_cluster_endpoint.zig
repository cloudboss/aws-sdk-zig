/// This data type represents the information you need to connect to an Amazon
/// Aurora DB cluster. This data type is used as a response element in the
/// following actions:
///
/// * `CreateDBClusterEndpoint`
/// * `DescribeDBClusterEndpoints`
/// * `ModifyDBClusterEndpoint`
/// * `DeleteDBClusterEndpoint`
///
/// For the data structure that represents Amazon RDS DB instance endpoints, see
/// `Endpoint`.
pub const DBClusterEndpoint = struct {
    /// The type associated with a custom endpoint. One of: `READER`, `WRITER`,
    /// `ANY`.
    custom_endpoint_type: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the endpoint.
    db_cluster_endpoint_arn: ?[]const u8 = null,

    /// The identifier associated with the endpoint. This parameter is stored as a
    /// lowercase string.
    db_cluster_endpoint_identifier: ?[]const u8 = null,

    /// A unique system-generated identifier for an endpoint. It remains the same
    /// for the whole life of the endpoint.
    db_cluster_endpoint_resource_identifier: ?[]const u8 = null,

    /// The DB cluster identifier of the DB cluster associated with the endpoint.
    /// This parameter is stored as a lowercase string.
    db_cluster_identifier: ?[]const u8 = null,

    /// The DNS address of the endpoint.
    endpoint: ?[]const u8 = null,

    /// The type of the endpoint. One of: `READER`, `WRITER`, `CUSTOM`.
    endpoint_type: ?[]const u8 = null,

    /// List of DB instance identifiers that aren't part of the custom endpoint
    /// group. All other eligible instances are reachable through the custom
    /// endpoint. Only relevant if the list of static members is empty.
    excluded_members: ?[]const []const u8 = null,

    /// List of DB instance identifiers that are part of the custom endpoint group.
    static_members: ?[]const []const u8 = null,

    /// The current status of the endpoint. One of: `creating`, `available`,
    /// `deleting`, `inactive`, `modifying`. The `inactive` state applies to an
    /// endpoint that can't be used for a certain kind of cluster, such as a
    /// `writer` endpoint for a read-only secondary cluster in a global database.
    status: ?[]const u8 = null,
};
