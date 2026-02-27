const Tag = @import("tag.zig").Tag;

/// The snapshot copy grant that grants Amazon Redshift permission to encrypt
/// copied
/// snapshots with the specified encrypted symmetric key from Amazon Web
/// Services KMS in the destination
/// region.
///
/// For more information about managing snapshot copy grants, go to
/// [Amazon Redshift Database
/// Encryption](https://docs.aws.amazon.com/redshift/latest/mgmt/working-with-db-encryption.html)
/// in the *Amazon Redshift Cluster Management Guide*.
pub const SnapshotCopyGrant = struct {
    /// The unique identifier of the encrypted symmetric key in Amazon Web Services
    /// KMS to which
    /// Amazon Redshift is granted permission.
    kms_key_id: ?[]const u8,

    /// The name of the snapshot copy grant.
    snapshot_copy_grant_name: ?[]const u8,

    /// A list of tag instances.
    tags: ?[]const Tag,
};
