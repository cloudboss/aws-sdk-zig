/// A revision is a container for one or more assets.
pub const RevisionEntry = struct {
    /// The ARN for the revision.
    arn: []const u8,

    /// An optional comment about the revision.
    comment: ?[]const u8,

    /// The date and time that the revision was created, in ISO 8601 format.
    created_at: i64,

    /// The unique identifier for the data set associated with the data set
    /// revision.
    data_set_id: []const u8,

    /// To publish a revision to a data set in a product, the revision must first be
    /// finalized.
    /// Finalizing a revision tells AWS Data Exchange that your changes to the
    /// assets in the
    /// revision are complete. After it's in this read-only state, you can publish
    /// the revision to
    /// your products. Finalized revisions can be published through the AWS Data
    /// Exchange console
    /// or the AWS Marketplace Catalog API, using the StartChangeSet AWS Marketplace
    /// Catalog API
    /// action. When using the API, revisions are uniquely identified by their ARN.
    finalized: bool = false,

    /// The unique identifier for the revision.
    id: []const u8,

    /// A required comment to inform subscribers of the reason their access to the
    /// revision was
    /// revoked.
    revocation_comment: ?[]const u8,

    /// A status indicating that subscribers' access to the revision was revoked.
    revoked: bool = false,

    /// The date and time that the revision was revoked, in ISO 8601 format.
    revoked_at: ?i64,

    /// The revision ID of the owned revision corresponding to the entitled revision
    /// being
    /// viewed. This parameter is returned when a revision owner is viewing the
    /// entitled copy of
    /// its owned revision.
    source_id: ?[]const u8,

    /// The date and time that the revision was last updated, in ISO 8601 format.
    updated_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .comment = "Comment",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .finalized = "Finalized",
        .id = "Id",
        .revocation_comment = "RevocationComment",
        .revoked = "Revoked",
        .revoked_at = "RevokedAt",
        .source_id = "SourceId",
        .updated_at = "UpdatedAt",
    };
};
