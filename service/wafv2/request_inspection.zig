const PasswordField = @import("password_field.zig").PasswordField;
const PayloadType = @import("payload_type.zig").PayloadType;
const UsernameField = @import("username_field.zig").UsernameField;

/// The criteria for inspecting login requests, used by the ATP rule group to
/// validate credentials usage.
///
/// This is part of the `AWSManagedRulesATPRuleSet` configuration in
/// `ManagedRuleGroupConfig`.
///
/// In these settings, you specify how your application accepts login attempts
/// by providing the request payload type and the names of the fields
/// within the request body where the username and password are provided.
pub const RequestInspection = struct {
    /// The name of the field in the request payload that contains your customer's
    /// password.
    ///
    /// How you specify this depends on the request inspection payload type.
    ///
    /// * For JSON payloads, specify the field name in JSON
    /// pointer syntax. For information about the JSON Pointer
    /// syntax, see the Internet Engineering Task Force (IETF)
    /// documentation [JavaScript
    /// Object Notation (JSON) Pointer](https://tools.ietf.org/html/rfc6901).
    ///
    /// For example, for the JSON payload `{ "form": { "password": "THE_PASSWORD" }
    /// }`,
    /// the password field specification is `/form/password`.
    ///
    /// * For form encoded payload types, use the HTML form names.
    ///
    /// For example, for an HTML form with the input element
    /// named `password1`, the password field specification is `password1`.
    password_field: PasswordField,

    /// The payload type for your login endpoint, either JSON or form encoded.
    payload_type: PayloadType,

    /// The name of the field in the request payload that contains your customer's
    /// username.
    ///
    /// How you specify this depends on the request inspection payload type.
    ///
    /// * For JSON payloads, specify the field name in JSON
    /// pointer syntax. For information about the JSON Pointer
    /// syntax, see the Internet Engineering Task Force (IETF)
    /// documentation [JavaScript
    /// Object Notation (JSON) Pointer](https://tools.ietf.org/html/rfc6901).
    ///
    /// For example, for the JSON payload `{ "form": { "username": "THE_USERNAME" }
    /// }`,
    /// the username field specification is `/form/username`.
    ///
    /// * For form encoded payload types, use the HTML form names.
    ///
    /// For example, for an HTML form with the input element
    /// named `username1`, the username field specification is
    /// `username1`
    username_field: UsernameField,

    pub const json_field_names = .{
        .password_field = "PasswordField",
        .payload_type = "PayloadType",
        .username_field = "UsernameField",
    };
};
