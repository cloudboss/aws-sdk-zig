const ResourceDataSyncDestinationDataSharing = @import("resource_data_sync_destination_data_sharing.zig").ResourceDataSyncDestinationDataSharing;
const ResourceDataSyncS3Format = @import("resource_data_sync_s3_format.zig").ResourceDataSyncS3Format;

/// Information about the target S3 bucket for the resource data sync.
pub const ResourceDataSyncS3Destination = struct {
    /// The ARN of an encryption key for a destination in Amazon S3. Must belong to
    /// the same
    /// Region as the destination S3 bucket.
    awskms_key_arn: ?[]const u8,

    /// The name of the S3 bucket where the aggregated data is stored.
    bucket_name: []const u8,

    /// Enables destination data sharing. By default, this field is `null`.
    destination_data_sharing: ?ResourceDataSyncDestinationDataSharing,

    /// An Amazon S3 prefix for the bucket.
    prefix: ?[]const u8,

    /// The Amazon Web Services Region with the S3 bucket targeted by the resource
    /// data sync.
    region: []const u8,

    /// A supported sync format. The following format is currently supported:
    /// JsonSerDe
    sync_format: ResourceDataSyncS3Format,

    pub const json_field_names = .{
        .awskms_key_arn = "AWSKMSKeyARN",
        .bucket_name = "BucketName",
        .destination_data_sharing = "DestinationDataSharing",
        .prefix = "Prefix",
        .region = "Region",
        .sync_format = "SyncFormat",
    };
};
