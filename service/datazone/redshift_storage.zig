const RedshiftClusterStorage = @import("redshift_cluster_storage.zig").RedshiftClusterStorage;
const RedshiftServerlessStorage = @import("redshift_serverless_storage.zig").RedshiftServerlessStorage;

/// The details of the Amazon Redshift storage as part of the configuration of
/// an Amazon Redshift data source run.
pub const RedshiftStorage = union(enum) {
    /// The details of the Amazon Redshift cluster source.
    redshift_cluster_source: ?RedshiftClusterStorage,
    /// The details of the Amazon Redshift Serverless workgroup source.
    redshift_serverless_source: ?RedshiftServerlessStorage,

    pub const json_field_names = .{
        .redshift_cluster_source = "redshiftClusterSource",
        .redshift_serverless_source = "redshiftServerlessSource",
    };
};
