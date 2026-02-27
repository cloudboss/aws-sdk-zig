/// The name of a field in the request payload that contains part or all of your
/// customer's primary phone number.
///
/// This data type is used in the `RequestInspectionACFP` data type.
pub const PhoneNumberField = struct {
    /// The name of a single primary phone number field.
    ///
    /// How you specify the phone number fields depends on the request inspection
    /// payload type.
    ///
    /// * For JSON payloads, specify the field identifiers in JSON
    /// pointer syntax. For information about the JSON Pointer
    /// syntax, see the Internet Engineering Task Force (IETF)
    /// documentation [JavaScript
    /// Object Notation (JSON) Pointer](https://tools.ietf.org/html/rfc6901).
    ///
    /// For example, for the JSON payload `{ "form": { "primaryphoneline1":
    /// "THE_PHONE1", "primaryphoneline2": "THE_PHONE2", "primaryphoneline3":
    /// "THE_PHONE3" } }`,
    /// the phone number field identifiers are `/form/primaryphoneline1`,
    /// `/form/primaryphoneline2`, and `/form/primaryphoneline3`.
    ///
    /// * For form encoded payload types, use the HTML form names.
    ///
    /// For example, for an HTML form with input elements
    /// named `primaryphoneline1`, `primaryphoneline2`, and `primaryphoneline3`, the
    /// phone number field identifiers are `primaryphoneline1`, `primaryphoneline2`,
    /// and `primaryphoneline3`.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
