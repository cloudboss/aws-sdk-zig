const statusType = @import("status_type.zig").statusType;

/// Contains information about an SSH public key, without the key's body or
/// fingerprint.
///
/// This data type is used as a response element in the
/// [ListSSHPublicKeys](https://docs.aws.amazon.com/IAM/latest/APIReference/API_ListSSHPublicKeys.html)
/// operation.
pub const SSHPublicKeyMetadata = struct {
    /// The unique identifier for the SSH public key.
    ssh_public_key_id: []const u8,

    /// The status of the SSH public key. `Active` means that the key can be used
    /// for
    /// authentication with an CodeCommit repository. `Inactive` means that the key
    /// cannot be
    /// used.
    status: statusType,

    /// The date and time, in [ISO 8601 date-time
    /// format](http://www.iso.org/iso/iso8601), when the SSH public key was
    /// uploaded.
    upload_date: i64,

    /// The name of the IAM user associated with the SSH public key.
    user_name: []const u8,
};
