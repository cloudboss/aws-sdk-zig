/// The name of a field in the request payload that contains part or all of your
/// customer's primary physical address.
///
/// This data type is used in the `RequestInspectionACFP` data type.
pub const AddressField = struct {
    /// The name of a single primary address field.
    ///
    /// How you specify the address fields depends on the request inspection payload
    /// type.
    ///
    /// * For JSON payloads, specify the field identifiers in JSON
    /// pointer syntax. For information about the JSON Pointer
    /// syntax, see the Internet Engineering Task Force (IETF)
    /// documentation [JavaScript
    /// Object Notation (JSON) Pointer](https://tools.ietf.org/html/rfc6901).
    ///
    /// For example, for the JSON payload `{ "form": { "primaryaddressline1":
    /// "THE_ADDRESS1", "primaryaddressline2": "THE_ADDRESS2",
    /// "primaryaddressline3": "THE_ADDRESS3" } }`,
    /// the address field idenfiers are `/form/primaryaddressline1`,
    /// `/form/primaryaddressline2`, and `/form/primaryaddressline3`.
    ///
    /// * For form encoded payload types, use the HTML form names.
    ///
    /// For example, for an HTML form with input elements
    /// named `primaryaddressline1`, `primaryaddressline2`, and
    /// `primaryaddressline3`, the address fields identifiers are
    /// `primaryaddressline1`, `primaryaddressline2`, and `primaryaddressline3`.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};
