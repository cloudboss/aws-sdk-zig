/// Synchronize Amazon Web Services Systems Manager Inventory data from multiple
/// Amazon Web Services accounts defined in Organizations to a
/// centralized Amazon S3 bucket. Data is synchronized to individual key
/// prefixes in the
/// central bucket. Each key prefix represents a different Amazon Web Services
/// account ID.
pub const ResourceDataSyncDestinationDataSharing = struct {
    /// The sharing data type. Only `Organization` is supported.
    destination_data_sharing_type: ?[]const u8,

    pub const json_field_names = .{
        .destination_data_sharing_type = "DestinationDataSharingType",
    };
};
