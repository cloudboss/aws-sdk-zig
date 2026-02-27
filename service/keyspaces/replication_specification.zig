const rs = @import("rs.zig").rs;

/// The replication specification of the keyspace includes:
///
/// * `regionList` - the Amazon Web Services Regions where the keyspace is
///   replicated in.
/// * `replicationStrategy` - the required value is `SINGLE_REGION` or
///   `MULTI_REGION`.
pub const ReplicationSpecification = struct {
    /// The `regionList` contains the Amazon Web Services Regions where the keyspace
    /// is replicated in.
    region_list: ?[]const []const u8,

    /// The `replicationStrategy` of a keyspace, the required value is
    /// `SINGLE_REGION` or `MULTI_REGION`.
    replication_strategy: rs,

    pub const json_field_names = .{
        .region_list = "regionList",
        .replication_strategy = "replicationStrategy",
    };
};
