/// The NameNode of the Hadoop Distributed File System (HDFS). The NameNode
/// manages the file
/// system's namespace. The NameNode performs operations such as opening,
/// closing, and renaming
/// files and directories. The NameNode contains the information to map blocks
/// of data to the
/// DataNodes.
pub const HdfsNameNode = struct {
    /// The hostname of the NameNode in the HDFS cluster. This value is the IP
    /// address or Domain
    /// Name Service (DNS) name of the NameNode. An agent that's installed
    /// on-premises uses this
    /// hostname to communicate with the NameNode in the network.
    hostname: []const u8,

    /// The port that the NameNode uses to listen to client requests.
    port: i32,

    pub const json_field_names = .{
        .hostname = "Hostname",
        .port = "Port",
    };
};
