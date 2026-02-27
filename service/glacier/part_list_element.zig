/// A list of the part sizes of the multipart upload.
pub const PartListElement = struct {
    /// The byte range of a part, inclusive of the upper value of the range.
    range_in_bytes: ?[]const u8,

    /// The SHA256 tree hash value that Amazon Glacier calculated for the part. This
    /// field is
    /// never `null`.
    sha256_tree_hash: ?[]const u8,

    pub const json_field_names = .{
        .range_in_bytes = "RangeInBytes",
        .sha256_tree_hash = "SHA256TreeHash",
    };
};
