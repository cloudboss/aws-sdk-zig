const BlobMetadata = @import("blob_metadata.zig").BlobMetadata;
const ChangeTypeEnum = @import("change_type_enum.zig").ChangeTypeEnum;

/// Returns information about a set of differences for a commit specifier.
pub const Difference = struct {
    /// Information about an `afterBlob` data type object, including the ID,
    /// the file mode permission code, and the path.
    after_blob: ?BlobMetadata = null,

    /// Information about a `beforeBlob` data type object, including the ID,
    /// the file mode permission code, and the path.
    before_blob: ?BlobMetadata = null,

    /// Whether the change type of the difference is an addition (A), deletion (D),
    /// or modification (M).
    change_type: ?ChangeTypeEnum = null,

    pub const json_field_names = .{
        .after_blob = "afterBlob",
        .before_blob = "beforeBlob",
        .change_type = "changeType",
    };
};
