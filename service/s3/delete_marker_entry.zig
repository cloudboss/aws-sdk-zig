const Owner = @import("owner.zig").Owner;

/// Information about the delete marker.
pub const DeleteMarkerEntry = struct {
    /// Specifies whether the object is (true) or is not (false) the latest version
    /// of an object.
    is_latest: ?bool,

    /// The object key.
    key: ?[]const u8,

    /// Date and time when the object was last modified.
    last_modified: ?i64,

    /// The account that created the delete marker.
    owner: ?Owner,

    /// Version ID of an object.
    version_id: ?[]const u8,
};
