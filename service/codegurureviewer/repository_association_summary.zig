const ProviderType = @import("provider_type.zig").ProviderType;
const RepositoryAssociationState = @import("repository_association_state.zig").RepositoryAssociationState;

/// Summary information about a repository association. The
/// [ListRepositoryAssociations](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_ListRepositoryAssociations.html) operation returns a list of
/// `RepositoryAssociationSummary` objects.
pub const RepositoryAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the
    /// [RepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_RepositoryAssociation.html) object. You can retrieve this ARN by calling [ListRepositoryAssociations](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_ListRepositoryAssociations.html).
    association_arn: ?[]const u8,

    /// The repository association ID.
    association_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an Amazon Web Services CodeStar
    /// Connections connection. Its format is
    /// `arn:aws:codestar-connections:region-id:aws-account_id:connection/connection-id`. For more information, see [Connection](https://docs.aws.amazon.com/codestar-connections/latest/APIReference/API_Connection.html) in the *Amazon Web Services CodeStar Connections API Reference*.
    connection_arn: ?[]const u8,

    /// The time, in milliseconds since the epoch, since the repository association
    /// was last
    /// updated.
    last_updated_time_stamp: ?i64,

    /// The name of the repository association.
    name: ?[]const u8,

    /// The owner of the repository. For an Amazon Web Services CodeCommit
    /// repository, this is the Amazon Web Services account ID of the
    /// account that owns the repository. For a GitHub, GitHub Enterprise Server, or
    /// Bitbucket repository, this is the username for the account that owns the
    /// repository.
    /// For an S3 repository, it can be the username or Amazon Web Services account
    /// ID.
    owner: ?[]const u8,

    /// The provider type of the repository association.
    provider_type: ?ProviderType,

    /// The state of the repository association.
    ///
    /// The valid repository association states are:
    ///
    /// * **Associated**: The repository association is complete.
    ///
    /// * **Associating**: CodeGuru Reviewer is:
    ///
    /// * Setting up pull request notifications. This is required
    /// for pull requests to trigger a CodeGuru Reviewer review.
    ///
    /// If your repository `ProviderType` is `GitHub`, `GitHub Enterprise Server`,
    /// or `Bitbucket`, CodeGuru Reviewer creates webhooks in your repository to
    /// trigger CodeGuru Reviewer reviews. If you delete these webhooks, reviews of
    /// code in your repository cannot be triggered.
    ///
    /// * Setting up source code access. This is required for CodeGuru Reviewer to
    ///   securely clone code in your repository.
    ///
    /// * **Failed**: The repository failed to associate or disassociate.
    ///
    /// * **Disassociating**: CodeGuru Reviewer is removing the repository's pull
    ///   request notifications and source code access.
    ///
    /// * **Disassociated**: CodeGuru Reviewer successfully disassociated the
    ///   repository. You can create a new association with this repository if you
    ///   want to review source code in it later. You can control access to code
    ///   reviews created in anassociated repository with tags after it has been
    ///   disassociated. For more information, see [Using tags to control access to
    ///   associated
    ///   repositories](https://docs.aws.amazon.com/codeguru/latest/reviewer-ug/auth-and-access-control-using-tags.html) in the *Amazon CodeGuru Reviewer User Guide*.
    state: ?RepositoryAssociationState,

    pub const json_field_names = .{
        .association_arn = "AssociationArn",
        .association_id = "AssociationId",
        .connection_arn = "ConnectionArn",
        .last_updated_time_stamp = "LastUpdatedTimeStamp",
        .name = "Name",
        .owner = "Owner",
        .provider_type = "ProviderType",
        .state = "State",
    };
};
