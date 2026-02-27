const aws = @import("aws");

const TermsEnforcementType = @import("terms_enforcement_type.zig").TermsEnforcementType;
const TermsSourceType = @import("terms_source_type.zig").TermsSourceType;

/// The details of a set of terms documents. For more information, see [Terms
/// documents](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-terms-documents).
pub const TermsType = struct {
    /// The ID of the app client that the terms documents are assigned to.
    client_id: []const u8,

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

    /// A map of URLs to languages. For each localized language that will view the
    /// requested
    /// `TermsName`, assign a URL. A selection of `cognito:default`
    /// displays for all languages that don't have a language-specific URL.
    ///
    /// For example, `"cognito:default": "https://terms.example.com",
    /// "cognito:spanish":
    /// "https://terms.example.com/es"`.
    links: []const aws.map.StringMapEntry,

    /// The ID of the terms documents.
    terms_id: []const u8,

    /// The type and friendly name of the terms documents.
    terms_name: []const u8,

    /// This parameter is reserved for future use and currently accepts one value.
    terms_source: TermsSourceType,

    /// The ID of the user pool that contains the terms documents.
    user_pool_id: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .creation_date = "CreationDate",
        .enforcement = "Enforcement",
        .last_modified_date = "LastModifiedDate",
        .links = "Links",
        .terms_id = "TermsId",
        .terms_name = "TermsName",
        .terms_source = "TermsSource",
        .user_pool_id = "UserPoolId",
    };
};
