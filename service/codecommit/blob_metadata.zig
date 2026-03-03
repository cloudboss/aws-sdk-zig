/// Returns information about a specific Git blob object.
pub const BlobMetadata = struct {
    /// The full ID of the blob.
    blob_id: ?[]const u8 = null,

    /// The file mode permissions of the blob. File mode permission codes include:
    ///
    /// * `100644` indicates read/write
    ///
    /// * `100755` indicates read/write/execute
    ///
    /// * `160000` indicates a submodule
    ///
    /// * `120000` indicates a symlink
    mode: ?[]const u8 = null,

    /// The path to the blob and associated file name, if any.
    path: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob_id = "blobId",
        .mode = "mode",
        .path = "path",
    };
};
