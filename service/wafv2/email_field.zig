/// The name of the field in the request payload that contains your customer's
/// email.
///
/// This data type is used in the `RequestInspectionACFP` data type.
pub const EmailField = struct {
    /// The name of the email field.
    ///
    /// How you specify this depends on the request inspection payload type.
    ///
    /// * For JSON payloads, specify the field name in JSON
    /// pointer syntax. For information about the JSON Pointer
    /// syntax, see the Internet Engineering Task Force (IETF)
    /// documentation [JavaScript
    /// Object Notation (JSON) Pointer](https://tools.ietf.org/html/rfc6901).
    ///
    /// For example, for the JSON payload `{ "form": { "email": "THE_EMAIL" } }`,
    /// the email field specification is `/form/email`.
    ///
    /// * For form encoded payload types, use the HTML form names.
    ///
    /// For example, for an HTML form with the input element
    /// named `email1`, the email field specification is `email1`.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
