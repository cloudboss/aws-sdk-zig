const ServerSideEncryptionUpdateStatus = @import("server_side_encryption_update_status.zig").ServerSideEncryptionUpdateStatus;

/// Details about the most recent server-side encryption configuration update.
/// When the
/// server-side encryption configuration is changed, dependency on the old KMS
/// key is removed through an asynchronous process. When this update is
/// complete, the domain’s data can only be accessed using the new KMS key.
pub const ServerSideEncryptionUpdateDetails = struct {
    /// Message explaining the current UpdateStatus. When the UpdateStatus is
    /// FAILED, this
    /// message explains the cause of the failure.
    message: ?[]const u8,

    /// The previous KMS key ID the domain was encrypted with, before
    /// ServerSideEncryptionConfiguration was updated to a new KMS key ID.
    old_kms_key_id: ?[]const u8,

    /// Status of the server-side encryption update. During an update, if there is
    /// an issue
    /// with the domain's current or old KMS key ID, such as an inaccessible or
    /// disabled key, then the status is FAILED. In order to resolve this, the key
    /// needs to be
    /// made accessible, and then an UpdateDomain call with the existing server-side
    /// encryption
    /// configuration will re-attempt this update process.
    update_status: ?ServerSideEncryptionUpdateStatus,

    pub const json_field_names = .{
        .message = "Message",
        .old_kms_key_id = "OldKmsKeyId",
        .update_status = "UpdateStatus",
    };
};
