/// Information about a third-party source repository connected to CodeGuru
/// Reviewer.
pub const ThirdPartySourceRepository = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Web Services CodeStar
    /// Connections connection. Its format is
    /// `arn:aws:codestar-connections:region-id:aws-account_id:connection/connection-id`. For more information, see [Connection](https://docs.aws.amazon.com/codestar-connections/latest/APIReference/API_Connection.html) in the *Amazon Web Services CodeStar Connections API Reference*.
    connection_arn: []const u8,

    /// The name of the third party source repository.
    name: []const u8,

    /// The owner of the repository. For a GitHub, GitHub Enterprise, or Bitbucket
    /// repository,
    /// this is the username for the account that owns the repository. For an S3
    /// repository, this
    /// can be the username or Amazon Web Services account ID
    owner: []const u8,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .name = "Name",
        .owner = "Owner",
    };
};
