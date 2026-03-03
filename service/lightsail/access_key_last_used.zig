/// Describes the last time an access key was used.
///
/// This object does not include data in the response of a
/// [CreateBucketAccessKey](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateBucketAccessKey.html) action.
pub const AccessKeyLastUsed = struct {
    /// The date and time when the access key was most recently used.
    ///
    /// This value is null if the access key has not been used.
    last_used_date: ?i64 = null,

    /// The Amazon Web Services Region where this access key was most recently used.
    ///
    /// This value is `N/A` if the access key has not been used.
    region: ?[]const u8 = null,

    /// The name of the Amazon Web Services service with which this access key was
    /// most recently
    /// used.
    ///
    /// This value is `N/A` if the access key has not been used.
    service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_used_date = "lastUsedDate",
        .region = "region",
        .service_name = "serviceName",
    };
};
