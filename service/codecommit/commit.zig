const UserInfo = @import("user_info.zig").UserInfo;

/// Returns information about a specific commit.
pub const Commit = struct {
    /// Any other data associated with the specified commit.
    additional_data: ?[]const u8,

    /// Information about the author of the specified commit. Information includes
    /// the date in timestamp format with GMT offset, the name of the author, and
    /// the email address for the author, as configured
    /// in Git.
    author: ?UserInfo,

    /// The full SHA ID of the specified commit.
    commit_id: ?[]const u8,

    /// Information about the person who committed the specified commit, also known
    /// as the committer. Information includes
    /// the date in timestamp format with GMT offset, the name of the committer, and
    /// the email address for the committer, as configured
    /// in Git.
    ///
    /// For more information
    /// about the difference between an author and a committer in Git, see [Viewing
    /// the Commit History](http://git-scm.com/book/ch2-3.html) in Pro Git
    /// by Scott Chacon and Ben Straub.
    committer: ?UserInfo,

    /// The commit message associated with the specified commit.
    message: ?[]const u8,

    /// A list of parent commits for the specified commit. Each parent commit ID is
    /// the full commit ID.
    parents: ?[]const []const u8,

    /// Tree information for the specified commit.
    tree_id: ?[]const u8,

    pub const json_field_names = .{
        .additional_data = "additionalData",
        .author = "author",
        .commit_id = "commitId",
        .committer = "committer",
        .message = "message",
        .parents = "parents",
        .tree_id = "treeId",
    };
};
