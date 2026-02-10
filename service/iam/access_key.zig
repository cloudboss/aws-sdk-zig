const statusType = @import("status_type.zig").statusType;

/// Contains information about an Amazon Web Services access key.
///
/// This data type is used as a response element in the
/// [CreateAccessKey](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateAccessKey.html) and
/// [ListAccessKeys](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListAccessKeys.html) operations.
///
/// **Note:**
///
/// The `SecretAccessKey` value is returned only in response to
/// [CreateAccessKey](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateAccessKey.html). You can get a secret access key only when you first create
/// an access key; you cannot recover the secret access key later. If you lose a
/// secret
/// access key, you must create a new access key.
pub const AccessKey = struct {
    /// The ID for this access key.
    access_key_id: []const u8,

    /// The date when the access key was created.
    create_date: ?i64,

    /// The secret key used to sign requests.
    secret_access_key: []const u8,

    /// The status of the access key. `Active` means that the key is valid for API
    /// calls, while `Inactive` means it is not.
    status: statusType,

    /// The name of the IAM user that the access key is associated with.
    user_name: []const u8,
};
