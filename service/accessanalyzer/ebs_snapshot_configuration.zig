/// The proposed access control configuration for an Amazon EBS volume snapshot.
/// You can propose a configuration for a new Amazon EBS volume snapshot or an
/// Amazon EBS volume snapshot that you own by specifying the user IDs, groups,
/// and optional KMS encryption key. For more information, see
/// [ModifySnapshotAttribute](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifySnapshotAttribute.html).
pub const EbsSnapshotConfiguration = struct {
    /// The groups that have access to the Amazon EBS volume snapshot. If the value
    /// `all` is specified, then the Amazon EBS volume snapshot is public.
    ///
    /// * If the configuration is for an existing Amazon EBS volume snapshot and you
    ///   do not specify the `groups`, then the access preview uses the existing
    ///   shared `groups` for the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   `groups`, then the access preview considers the snapshot without any
    ///   `groups`.
    /// * To propose deletion of existing shared `groups`, you can specify an empty
    ///   list for `groups`.
    groups: ?[]const []const u8 = null,

    /// The KMS key identifier for an encrypted Amazon EBS volume snapshot. The KMS
    /// key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS
    /// key.
    ///
    /// * If the configuration is for an existing Amazon EBS volume snapshot and you
    ///   do not specify the `kmsKeyId`, or you specify an empty string, then the
    ///   access preview uses the existing `kmsKeyId` of the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   `kmsKeyId`, the access preview considers the snapshot as unencrypted.
    kms_key_id: ?[]const u8 = null,

    /// The IDs of the Amazon Web Services accounts that have access to the Amazon
    /// EBS volume snapshot.
    ///
    /// * If the configuration is for an existing Amazon EBS volume snapshot and you
    ///   do not specify the `userIds`, then the access preview uses the existing
    ///   shared `userIds` for the snapshot.
    /// * If the access preview is for a new resource and you do not specify the
    ///   `userIds`, then the access preview considers the snapshot without any
    ///   `userIds`.
    /// * To propose deletion of existing shared `accountIds`, you can specify an
    ///   empty list for `userIds`.
    user_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .groups = "groups",
        .kms_key_id = "kmsKeyId",
        .user_ids = "userIds",
    };
};
