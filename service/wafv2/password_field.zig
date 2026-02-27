/// The name of the field in the request payload that contains your customer's
/// password.
///
/// This data type is used in the `RequestInspection` and
/// `RequestInspectionACFP` data types.
pub const PasswordField = struct {
    /// The name of the password field.
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
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
