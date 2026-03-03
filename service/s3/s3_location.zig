const Grant = @import("grant.zig").Grant;
const ObjectCannedACL = @import("object_canned_acl.zig").ObjectCannedACL;
const Encryption = @import("encryption.zig").Encryption;
const StorageClass = @import("storage_class.zig").StorageClass;
const Tagging = @import("tagging.zig").Tagging;
const MetadataEntry = @import("metadata_entry.zig").MetadataEntry;

/// Describes an Amazon S3 location that will receive the results of the restore
/// request.
pub const S3Location = struct {
    /// A list of grants that control access to the staged results.
    access_control_list: ?[]const Grant = null,

    /// The name of the bucket where the restore results will be placed.
    bucket_name: []const u8,

    /// The canned ACL to apply to the restore results.
    canned_acl: ?ObjectCannedACL = null,

    encryption: ?Encryption = null,

    /// The prefix that is prepended to the restore results for this request.
    prefix: []const u8,

    /// The class of storage used to store the restore results.
    storage_class: ?StorageClass = null,

    /// The tag-set that is applied to the restore results.
    tagging: ?Tagging = null,

    /// A list of metadata to store with the restore results in S3.
    user_metadata: ?[]const MetadataEntry = null,
};
