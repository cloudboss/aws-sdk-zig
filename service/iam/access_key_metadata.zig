const statusType = @import("status_type.zig").statusType;

/// Contains information about an Amazon Web Services access key, without its
/// secret key.
///
/// This data type is used as a response element in the
/// [ListAccessKeys](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListAccessKeys.html)
/// operation.
pub const AccessKeyMetadata = struct {
    /// The ID for this access key.
    access_key_id: ?[]const u8,

    /// The date when the access key was created.
    create_date: ?i64,

    /// The status of the access key. `Active` means that the key is valid for API
    /// calls; `Inactive` means it is not.
    status: ?statusType,

    /// The name of the IAM user that the key is associated with.
    user_name: ?[]const u8,
};
