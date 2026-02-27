const TermsEnforcementType = @import("terms_enforcement_type.zig").TermsEnforcementType;

/// The details of a set of terms documents. For more information, see [Terms
/// documents](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-terms-documents).
pub const TermsDescriptionType = struct {
    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: i64,

    /// This parameter is reserved for future use and currently accepts one value.
    enforcement: TermsEnforcementType,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: i64,

    /// The ID of the requested terms documents.
    terms_id: []const u8,

    /// The type and friendly name of the requested terms documents.
    terms_name: []const u8,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .enforcement = "Enforcement",
        .last_modified_date = "LastModifiedDate",
        .terms_id = "TermsId",
        .terms_name = "TermsName",
    };
};
