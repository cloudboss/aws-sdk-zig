const Comment = @import("comment.zig").Comment;
const Location = @import("location.zig").Location;

/// Returns information about comments on the comparison between two commits.
pub const CommentsForComparedCommit = struct {
    /// The full blob ID of the commit used to establish the after of the
    /// comparison.
    after_blob_id: ?[]const u8,

    /// The full commit ID of the commit used to establish the after of the
    /// comparison.
    after_commit_id: ?[]const u8,

    /// The full blob ID of the commit used to establish the before of the
    /// comparison.
    before_blob_id: ?[]const u8,

    /// The full commit ID of the commit used to establish the before of the
    /// comparison.
    before_commit_id: ?[]const u8,

    /// An array of comment objects. Each comment object contains information about
    /// a comment on the comparison
    /// between commits.
    comments: ?[]const Comment,

    /// Location information about the comment on the comparison, including the file
    /// name,
    /// line number, and whether the version of the file where the comment was made
    /// is BEFORE or
    /// AFTER.
    location: ?Location,

    /// The name of the repository that contains the compared commits.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .after_blob_id = "afterBlobId",
        .after_commit_id = "afterCommitId",
        .before_blob_id = "beforeBlobId",
        .before_commit_id = "beforeCommitId",
        .comments = "comments",
        .location = "location",
        .repository_name = "repositoryName",
    };
};
