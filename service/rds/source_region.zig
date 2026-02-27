/// Contains an Amazon Web Services Region name as the result of a successful
/// call to the `DescribeSourceRegions` action.
pub const SourceRegion = struct {
    /// The endpoint for the source Amazon Web Services Region endpoint.
    endpoint: ?[]const u8,

    /// The name of the source Amazon Web Services Region.
    region_name: ?[]const u8,

    /// The status of the source Amazon Web Services Region.
    status: ?[]const u8,

    /// Indicates whether the source Amazon Web Services Region supports replicating
    /// automated backups to the current Amazon Web Services Region.
    supports_db_instance_automated_backups_replication: ?bool,
};
