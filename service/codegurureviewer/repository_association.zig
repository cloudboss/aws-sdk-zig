const KMSKeyDetails = @import("kms_key_details.zig").KMSKeyDetails;
const ProviderType = @import("provider_type.zig").ProviderType;
const S3RepositoryDetails = @import("s3_repository_details.zig").S3RepositoryDetails;
const RepositoryAssociationState = @import("repository_association_state.zig").RepositoryAssociationState;

/// Information about a repository association. The
/// [DescribeRepositoryAssociation](https://docs.aws.amazon.com/codeguru/latest/reviewer-api/API_DescribeRepositoryAssociation.html) operation returns a
/// `RepositoryAssociation` object.
pub const RepositoryAssociation = struct {
    /// The Amazon Resource Name (ARN) identifying the repository association.
    association_arn: ?[]const u8,

    /// The ID of the repository association.
    association_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of an Amazon Web Services CodeStar
    /// Connections connection. Its format is
    /// `arn:aws:codestar-connections:region-id:aws-account_id:connection/connection-id`. For more information, see [Connection](https://docs.aws.amazon.com/codestar-connections/latest/APIReference/API_Connection.html) in the *Amazon Web Services CodeStar Connections API Reference*.
    connection_arn: ?[]const u8,

    /// The time, in milliseconds since the epoch, when the repository association
    /// was
    /// created.
    created_time_stamp: ?i64,

    /// A `KMSKeyDetails` object that contains:
    ///
    /// * The encryption option for this repository association. It is either owned
    ///   by Amazon Web Services
    /// Key Management Service (KMS) (`AWS_OWNED_CMK`) or customer managed
    /// (`CUSTOMER_MANAGED_CMK`).
    ///
    /// * The ID of the Amazon Web Services KMS key that is associated with this
    ///   repository
    /// association.
    kms_key_details: ?KMSKeyDetails,

    /// The time, in milliseconds since the epoch, when the repository association
    /// was last
    /// updated.
    last_updated_time_stamp: ?i64,

    /// The name of the repository.
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

    s3_repository_details: ?S3RepositoryDetails,

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

    /// A description of why the repository association is in the current state.
    state_reason: ?[]const u8,

    pub const json_field_names = .{
        .association_arn = "AssociationArn",
        .association_id = "AssociationId",
        .connection_arn = "ConnectionArn",
        .created_time_stamp = "CreatedTimeStamp",
        .kms_key_details = "KMSKeyDetails",
        .last_updated_time_stamp = "LastUpdatedTimeStamp",
        .name = "Name",
        .owner = "Owner",
        .provider_type = "ProviderType",
        .s3_repository_details = "S3RepositoryDetails",
        .state = "State",
        .state_reason = "StateReason",
    };
};
