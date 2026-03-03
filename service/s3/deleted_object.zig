/// Information about the deleted object.
pub const DeletedObject = struct {
    /// Indicates whether the specified object version that was permanently deleted
    /// was (true) or was not
    /// (false) a delete marker before deletion. In a simple DELETE, this header
    /// indicates whether (true) or not
    /// (false) the current version of the object is a delete marker. To learn more
    /// about delete markers, see
    /// [Working with delete
    /// markers](https://docs.aws.amazon.com/AmazonS3/latest/userguide/DeleteMarker.html).
    ///
    /// This functionality is not supported for directory buckets.
    delete_marker: ?bool = null,

    /// The version ID of the delete marker created as a result of the DELETE
    /// operation. If you delete a
    /// specific object version, the value returned by this header is the version ID
    /// of the object version
    /// deleted.
    ///
    /// This functionality is not supported for directory buckets.
    delete_marker_version_id: ?[]const u8 = null,

    /// The name of the deleted object.
    key: ?[]const u8 = null,

    /// The version ID of the deleted object.
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8 = null,
};
