/// The connection mode for the cross-cluster connection.
///
/// * **DIRECT** - Used for cross-cluster search or
/// cross-cluster replication.
///
/// * **VPC_ENDPOINT** - Used for remote reindex
/// between Amazon OpenSearch Service VPC domains.
pub const ConnectionMode = enum {
    direct,
    vpc_endpoint,

    pub const json_field_names = .{
        .direct = "DIRECT",
        .vpc_endpoint = "VPC_ENDPOINT",
    };
};
