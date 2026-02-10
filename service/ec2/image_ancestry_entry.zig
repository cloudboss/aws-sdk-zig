/// Information about a single AMI in the ancestry chain and its source (parent)
/// AMI.
pub const ImageAncestryEntry = struct {
    /// The date and time when this AMI was created.
    creation_date: ?i64,

    /// The ID of this AMI.
    image_id: ?[]const u8,

    /// The owner alias (`amazon` | `aws-backup-vault` |
    /// `aws-marketplace` ) of this AMI, if one is assigned. Otherwise, the value is
    /// `null`.
    image_owner_alias: ?[]const u8,

    /// The ID of the parent AMI.
    source_image_id: ?[]const u8,

    /// The Amazon Web Services Region of the parent AMI.
    source_image_region: ?[]const u8,
};
