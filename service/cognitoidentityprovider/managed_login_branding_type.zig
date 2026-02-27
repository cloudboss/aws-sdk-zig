const AssetType = @import("asset_type.zig").AssetType;

/// A managed login branding style that's assigned to a user pool app client.
pub const ManagedLoginBrandingType = struct {
    /// An array of image files that you want to apply to roles like backgrounds,
    /// logos, and
    /// icons. Each object must also indicate whether it is for dark mode, light
    /// mode, or
    /// browser-adaptive mode.
    assets: ?[]const AssetType,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64,

    /// The ID of the managed login branding style.
    managed_login_branding_id: ?[]const u8,

    /// A JSON file, encoded as a `Document` type, with the the settings that you
    /// want to apply to your style.
    ///
    /// The following components are not currently implemented and reserved for
    /// future
    /// use:
    ///
    /// * `signUp`
    ///
    /// * `instructions`
    ///
    /// * `sessionTimerDisplay`
    ///
    /// * `languageSelector` (for localization, see [Managed login
    ///   localization)](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-pools-managed-login.html#managed-login-localization)
    settings: ?[]const u8,

    /// When true, applies the default branding style options. This option reverts
    /// to default
    /// style options that are managed by Amazon Cognito. You can modify them later
    /// in the branding
    /// editor.
    ///
    /// When you specify `true` for this option, you must also omit values for
    /// `Settings` and `Assets` in the request.
    use_cognito_provided_values: bool = false,

    /// The user pool where the branding style is assigned.
    user_pool_id: ?[]const u8,

    pub const json_field_names = .{
        .assets = "Assets",
        .creation_date = "CreationDate",
        .last_modified_date = "LastModifiedDate",
        .managed_login_branding_id = "ManagedLoginBrandingId",
        .settings = "Settings",
        .use_cognito_provided_values = "UseCognitoProvidedValues",
        .user_pool_id = "UserPoolId",
    };
};
