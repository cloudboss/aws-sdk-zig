const FieldToMatch = @import("field_to_match.zig").FieldToMatch;
const PositionalConstraint = @import("positional_constraint.zig").PositionalConstraint;
const TextTransformation = @import("text_transformation.zig").TextTransformation;

/// A rule statement that defines a string match search for WAF to apply to web
/// requests. The byte match statement provides the bytes to search for, the
/// location in requests that you want WAF to search, and other settings. The
/// bytes to search for are typically a string that corresponds with ASCII
/// characters. In the WAF console and the developer guide, this is called a
/// string match statement.
pub const ByteMatchStatement = struct {
    /// The part of the web request that you want WAF to inspect.
    field_to_match: FieldToMatch,

    /// The area within the portion of the web request that you want WAF to search
    /// for
    /// `SearchString`. Valid values include the following:
    ///
    /// **CONTAINS**
    ///
    /// The specified part of the web request must include the value of
    /// `SearchString`, but the location doesn't matter.
    ///
    /// **CONTAINS_WORD**
    ///
    /// The specified part of the web request must include the value of
    /// `SearchString`, and `SearchString` must contain only alphanumeric
    /// characters or underscore (A-Z, a-z, 0-9, or _). In addition, `SearchString`
    /// must
    /// be a word, which means that both of the following are true:
    ///
    /// * `SearchString` is at the beginning of the specified part of the web
    /// request or is preceded by a character other than an alphanumeric character
    /// or
    /// underscore (_). Examples include the value of a header and
    /// `;BadBot`.
    ///
    /// * `SearchString` is at the end of the specified part of the web request or
    /// is followed by a character other than an alphanumeric character or
    /// underscore (_),
    /// for example, `BadBot;` and `-BadBot;`.
    ///
    /// **EXACTLY**
    ///
    /// The value of the specified part of the web request must exactly match the
    /// value of
    /// `SearchString`.
    ///
    /// **STARTS_WITH**
    ///
    /// The value of `SearchString` must appear at the beginning of the specified
    /// part of the web request.
    ///
    /// **ENDS_WITH**
    ///
    /// The value of `SearchString` must appear at the end of the specified part of
    /// the web request.
    positional_constraint: PositionalConstraint,

    /// A string value that you want WAF to search for. WAF searches only in the
    /// part of
    /// web requests that you designate for inspection in FieldToMatch. The
    /// maximum length of the value is 200 bytes.
    ///
    /// Valid values depend on the component that you specify for inspection in
    /// `FieldToMatch`:
    ///
    /// * `Method`: The HTTP method that you want WAF to search for. This
    /// indicates the type of operation specified in the request.
    ///
    /// * `UriPath`: The value that you want WAF to search for in the URI path,
    /// for example, `/images/daily-ad.jpg`.
    ///
    /// * `JA3Fingerprint`: Available for use with Amazon CloudFront distributions
    ///   and Application Load Balancers. Match against the request's JA3
    ///   fingerprint. The JA3 fingerprint is a 32-character hash derived from the
    ///   TLS Client Hello of an incoming request. This fingerprint serves as a
    ///   unique identifier for the client's TLS configuration. You can use this
    ///   choice only with a string match `ByteMatchStatement` with the
    ///   `PositionalConstraint` set to
    /// `EXACTLY`.
    ///
    /// You can obtain the JA3 fingerprint for client requests from the web ACL
    /// logs.
    /// If WAF is able to calculate the fingerprint, it includes it in the logs.
    /// For information about the logging fields,
    /// see [Log
    /// fields](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html) in the *WAF Developer Guide*.
    ///
    /// * `HeaderOrder`: The list of header names to match for. WAF creates a
    /// string that contains the ordered list of header names, from the headers in
    /// the web request, and then matches against that string.
    ///
    /// If `SearchString` includes alphabetic characters A-Z and a-z, note that the
    /// value is case sensitive.
    ///
    /// **If you're using the WAF API**
    ///
    /// Specify a base64-encoded version of the value. The maximum length of the
    /// value before
    /// you base64-encode it is 200 bytes.
    ///
    /// For example, suppose the value of `Type` is `HEADER` and the value
    /// of `Data` is `User-Agent`. If you want to search the
    /// `User-Agent` header for the value `BadBot`, you base64-encode
    /// `BadBot` using MIME base64-encoding and include the resulting value,
    /// `QmFkQm90`, in the value of `SearchString`.
    ///
    /// **If you're using the CLI or one of the Amazon Web Services SDKs**
    ///
    /// The value that you want WAF to search for. The SDK automatically base64
    /// encodes the
    /// value.
    search_string: []const u8,

    /// Text transformations eliminate some of the unusual formatting that attackers
    /// use in web requests in an effort to bypass detection. Text transformations
    /// are used in rule match statements, to transform the `FieldToMatch` request
    /// component before inspecting it, and they're used in rate-based rule
    /// statements, to transform request components before using them as custom
    /// aggregation keys. If you specify one or more transformations to apply, WAF
    /// performs all transformations on the specified content, starting from the
    /// lowest priority setting, and then uses the transformed component contents.
    text_transformations: []const TextTransformation,

    pub const json_field_names = .{
        .field_to_match = "FieldToMatch",
        .positional_constraint = "PositionalConstraint",
        .search_string = "SearchString",
        .text_transformations = "TextTransformations",
    };
};
