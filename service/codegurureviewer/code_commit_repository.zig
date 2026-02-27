/// Information about an Amazon Web Services CodeCommit repository. The
/// CodeCommit repository must be in
/// the same Amazon Web Services Region and Amazon Web Services account where
/// its CodeGuru Reviewer code reviews are
/// configured.
pub const CodeCommitRepository = struct {
    /// The name of the Amazon Web Services CodeCommit repository. For more
    /// information, see
    /// [repositoryName](https://docs.aws.amazon.com/codecommit/latest/APIReference/API_GetRepository.html#CodeCommit-GetRepository-request-repositoryName) in the *Amazon Web Services CodeCommit API
    /// Reference*.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
