/// The connection endpoint for an Amazon Redshift cluster.
pub const AwsRedshiftClusterEndpoint = struct {
    /// The DNS address of the cluster.
    address: ?[]const u8,

    /// The port that the database engine listens on.
    port: ?i32,

    pub const json_field_names = .{
        .address = "Address",
        .port = "Port",
    };
};
