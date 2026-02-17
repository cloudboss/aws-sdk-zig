const S3KeyFilter = @import("s3_key_filter.zig").S3KeyFilter;

/// Specifies object key name filtering rules. For information about key name
/// filtering, see [Configuring
/// event notifications using object key name
/// filtering](https://docs.aws.amazon.com/AmazonS3/latest/userguide/notification-how-to-filtering.html) in the
/// *Amazon S3 User Guide*.
pub const NotificationConfigurationFilter = struct {
    key: ?S3KeyFilter,
};
