const HdfsDataTransferProtection = @import("hdfs_data_transfer_protection.zig").HdfsDataTransferProtection;
const HdfsRpcProtection = @import("hdfs_rpc_protection.zig").HdfsRpcProtection;

/// The Quality of Protection (QOP) configuration specifies the Remote Procedure
/// Call (RPC)
/// and data transfer privacy settings configured on the Hadoop Distributed File
/// System (HDFS)
/// cluster.
pub const QopConfiguration = struct {
    /// The data transfer protection setting configured on the HDFS cluster. This
    /// setting
    /// corresponds to your `dfs.data.transfer.protection` setting in the
    /// `hdfs-site.xml` file on your Hadoop cluster.
    data_transfer_protection: ?HdfsDataTransferProtection,

    /// The RPC protection setting configured on the HDFS cluster. This setting
    /// corresponds to
    /// your `hadoop.rpc.protection` setting in your `core-site.xml` file on
    /// your Hadoop cluster.
    rpc_protection: ?HdfsRpcProtection,

    pub const json_field_names = .{
        .data_transfer_protection = "DataTransferProtection",
        .rpc_protection = "RpcProtection",
    };
};
