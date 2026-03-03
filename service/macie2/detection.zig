const DataIdentifierType = @import("data_identifier_type.zig").DataIdentifierType;

/// Provides information about a type of sensitive data that Amazon Macie found
/// in an S3 bucket while performing automated sensitive data discovery for an
/// account. The information also specifies the custom or managed data
/// identifier that detected the data. This information is available only if
/// automated sensitive data discovery has been enabled for the account.
pub const Detection = struct {
    /// If the sensitive data was detected by a custom data identifier, the Amazon
    /// Resource Name (ARN) of the custom data identifier that detected the data.
    /// Otherwise, this value is null.
    arn: ?[]const u8 = null,

    /// The total number of occurrences of the sensitive data.
    count: ?i64 = null,

    /// The unique identifier for the custom data identifier or managed data
    /// identifier that detected the sensitive data. For additional details about a
    /// specified managed data identifier, see [Using managed data
    /// identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) in the *Amazon Macie User Guide*.
    id: ?[]const u8 = null,

    /// The name of the custom data identifier or managed data identifier that
    /// detected the sensitive data. For a managed data identifier, this value is
    /// the same as the unique identifier (id).
    name: ?[]const u8 = null,

    /// Specifies whether occurrences of this type of sensitive data are excluded
    /// (true) or included (false) in the bucket's sensitivity score, if the score
    /// is calculated by Amazon Macie.
    suppressed: ?bool = null,

    /// The type of data identifier that detected the sensitive data. Possible
    /// values are: CUSTOM, for a custom data identifier; and, MANAGED, for a
    /// managed data identifier.
    @"type": ?DataIdentifierType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .count = "count",
        .id = "id",
        .name = "name",
        .suppressed = "suppressed",
        .@"type" = "type",
    };
};
