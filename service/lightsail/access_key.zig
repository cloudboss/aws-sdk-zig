const AccessKeyLastUsed = @import("access_key_last_used.zig").AccessKeyLastUsed;
const StatusType = @import("status_type.zig").StatusType;

/// Describes an access key for an Amazon Lightsail bucket.
///
/// Access keys grant full programmatic access to the specified bucket and its
/// objects. You
/// can have a maximum of two access keys per bucket. Use the
/// [CreateBucketAccessKey](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateBucketAccessKey.html) action to create an access key for a specific bucket. For
/// more information about access keys, see [Creating access keys for a bucket
/// in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-creating-bucket-access-keys) in the
/// *Amazon Lightsail Developer Guide*.
///
/// The `secretAccessKey` value is returned only in response to the
/// `CreateBucketAccessKey` action. You can get a secret access key only when
/// you
/// first create an access key; you cannot get the secret access key later. If
/// you lose the
/// secret access key, you must create a new access key.
pub const AccessKey = struct {
    /// The ID of the access key.
    access_key_id: ?[]const u8 = null,

    /// The timestamp when the access key was created.
    created_at: ?i64 = null,

    /// An object that describes the last time the access key was used.
    ///
    /// This object does not include data in the response of a
    /// [CreateBucketAccessKey](https://docs.aws.amazon.com/lightsail/2016-11-28/api-reference/API_CreateBucketAccessKey.html) action. If the access key has not been used, the
    /// `region` and `serviceName` values are `N/A`, and the
    /// `lastUsedDate` value is null.
    last_used: ?AccessKeyLastUsed = null,

    /// The secret access key used to sign requests.
    ///
    /// You should store the secret access key in a safe location. We recommend that
    /// you delete
    /// the access key if the secret access key is compromised.
    secret_access_key: ?[]const u8 = null,

    /// The status of the access key.
    ///
    /// A status of `Active` means that the key is valid, while `Inactive`
    /// means it is not.
    status: ?StatusType = null,

    pub const json_field_names = .{
        .access_key_id = "accessKeyId",
        .created_at = "createdAt",
        .last_used = "lastUsed",
        .secret_access_key = "secretAccessKey",
        .status = "status",
    };
};
