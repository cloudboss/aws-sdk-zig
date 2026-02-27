const aws = @import("aws");

const RelationshipStatus = @import("relationship_status.zig").RelationshipStatus;

/// Provides information about an account that's associated with an Amazon Macie
/// administrator account.
pub const Member = struct {
    /// The Amazon Web Services account ID for the account.
    account_id: ?[]const u8,

    /// The Amazon Web Services account ID for the administrator account.
    administrator_account_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the account.
    arn: ?[]const u8,

    /// The email address for the account. This value is null if the account is
    /// associated with the administrator account through Organizations.
    email: ?[]const u8,

    /// The date and time, in UTC and extended ISO 8601 format, when an Amazon Macie
    /// membership invitation was last sent to the account. This value is null if a
    /// Macie membership invitation hasn't been sent to the account.
    invited_at: ?i64,

    /// (Deprecated) The Amazon Web Services account ID for the administrator
    /// account. This property has been replaced by the administratorAccountId
    /// property and is retained only for backward compatibility.
    master_account_id: ?[]const u8,

    /// The current status of the relationship between the account and the
    /// administrator account.
    relationship_status: ?RelationshipStatus,

    /// A map of key-value pairs that specifies which tags (keys and values) are
    /// associated with the account in Amazon Macie.
    tags: ?[]const aws.map.StringMapEntry,

    /// The date and time, in UTC and extended ISO 8601 format, of the most recent
    /// change to the status of the relationship between the account and the
    /// administrator account.
    updated_at: ?i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .administrator_account_id = "administratorAccountId",
        .arn = "arn",
        .email = "email",
        .invited_at = "invitedAt",
        .master_account_id = "masterAccountId",
        .relationship_status = "relationshipStatus",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
