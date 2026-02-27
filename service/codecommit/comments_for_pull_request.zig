const Comment = @import("comment.zig").Comment;
const Location = @import("location.zig").Location;

/// Returns information about comments on a pull request.
pub const CommentsForPullRequest = struct {
    /// The full blob ID of the file on which you want to comment on the source
    /// commit.
    after_blob_id: ?[]const u8,

    /// The full commit ID of the commit that was the tip of the source branch at
    /// the time the
    /// comment was made.
    after_commit_id: ?[]const u8,

    /// The full blob ID of the file on which you want to comment on the destination
    /// commit.
    before_blob_id: ?[]const u8,

    /// The full commit ID of the commit that was the tip of the destination branch
    /// when the
    /// pull request was created. This commit is superceded by the after commit in
    /// the source
    /// branch when and if you merge the source branch into the destination branch.
    before_commit_id: ?[]const u8,

    /// An array of comment objects. Each comment object contains information about
    /// a comment on the pull request.
    comments: ?[]const Comment,

    /// Location information about the comment on the pull request, including the
    /// file name,
    /// line number, and whether the version of the file where the comment was made
    /// is BEFORE
    /// (destination branch) or AFTER (source branch).
    location: ?Location,

    /// The system-generated ID of the pull request.
    pull_request_id: ?[]const u8,

    /// The name of the repository that contains the pull request.
    repository_name: ?[]const u8,

    pub const json_field_names = .{
        .after_blob_id = "afterBlobId",
        .after_commit_id = "afterCommitId",
        .before_blob_id = "beforeBlobId",
        .before_commit_id = "beforeCommitId",
        .comments = "comments",
        .location = "location",
        .pull_request_id = "pullRequestId",
        .repository_name = "repositoryName",
    };
};
