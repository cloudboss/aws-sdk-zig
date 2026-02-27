const Commit = @import("commit.zig").Commit;

/// Information about a version of a file.
pub const FileVersion = struct {
    /// The blob ID of the object that represents the content of the file in this
    /// version.
    blob_id: ?[]const u8,

    commit: ?Commit,

    /// The name and path of the file at which this blob is indexed which contains
    /// the data for this version of the file. This value will
    /// vary between file versions if a file is renamed or if its path changes.
    path: ?[]const u8,

    /// An array of commit IDs that contain more recent versions of this file. If
    /// there are no additional versions of the file, this array will be empty.
    revision_children: ?[]const []const u8,

    pub const json_field_names = .{
        .blob_id = "blobId",
        .commit = "commit",
        .path = "path",
        .revision_children = "revisionChildren",
    };
};
