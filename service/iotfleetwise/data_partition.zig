const DataPartitionStorageOptions = @import("data_partition_storage_options.zig").DataPartitionStorageOptions;
const DataPartitionUploadOptions = @import("data_partition_upload_options.zig").DataPartitionUploadOptions;

/// The configuration for signal data storage and upload options. You can only
/// specify these
/// options when the campaign's spooling mode is `TO_DISK`.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const DataPartition = struct {
    /// The ID of the data partition. The data partition ID must be unique within a
    /// campaign.
    /// You can establish a data partition as the default partition for a campaign
    /// by using
    /// `default` as the ID.
    id: []const u8,

    /// The storage options for a data partition.
    storage_options: DataPartitionStorageOptions,

    /// The upload options for the data partition.
    upload_options: ?DataPartitionUploadOptions = null,

    pub const json_field_names = .{
        .id = "id",
        .storage_options = "storageOptions",
        .upload_options = "uploadOptions",
    };
};
