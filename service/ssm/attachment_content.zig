const AttachmentHashType = @import("attachment_hash_type.zig").AttachmentHashType;

/// A structure that includes attributes that describe a document attachment.
pub const AttachmentContent = struct {
    /// The cryptographic hash value of the document content.
    hash: ?[]const u8 = null,

    /// The hash algorithm used to calculate the hash value.
    hash_type: ?AttachmentHashType = null,

    /// The name of an attachment.
    name: ?[]const u8 = null,

    /// The size of an attachment in bytes.
    size: i64 = 0,

    /// The URL location of the attachment content.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .hash = "Hash",
        .hash_type = "HashType",
        .name = "Name",
        .size = "Size",
        .url = "Url",
    };
};
