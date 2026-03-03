/// A container for the UI customization information for the hosted UI in a user
/// pool.
pub const UICustomizationType = struct {
    /// The app client ID for your UI customization. When this value isn't present,
    /// the
    /// customization applies to all user pool app clients that don't have
    /// client-level
    /// settings..
    client_id: ?[]const u8 = null,

    /// The date and time when the item was created. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    creation_date: ?i64 = null,

    /// The CSS values in the UI customization.
    css: ?[]const u8 = null,

    /// The CSS version number.
    css_version: ?[]const u8 = null,

    /// A URL path to the hosted logo image of your UI customization.
    image_url: ?[]const u8 = null,

    /// The date and time when the item was modified. Amazon Cognito returns this
    /// timestamp in UNIX epoch time format. Your SDK might render the output in a
    /// human-readable format like ISO 8601 or a Java `Date` object.
    last_modified_date: ?i64 = null,

    /// The ID of the user pool with hosted UI customizations.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .creation_date = "CreationDate",
        .css = "CSS",
        .css_version = "CSSVersion",
        .image_url = "ImageUrl",
        .last_modified_date = "LastModifiedDate",
        .user_pool_id = "UserPoolId",
    };
};
