const FallbackBehavior = @import("fallback_behavior.zig").FallbackBehavior;

/// Inspect fragments of the request URI. You can specify the parts of the URI
/// fragment to
/// inspect and you can narrow the set of URI fragments to inspect by including
/// or excluding specific
/// keys.
///
/// This is used to indicate the web request component to inspect, in the
/// FieldToMatch specification.
///
/// Example JSON: `"UriFragment": { "MatchPattern": { "All": {} }, "MatchScope":
/// "KEY",
/// "OversizeHandling": "MATCH" }`
pub const UriFragment = struct {
    /// What WAF should do if it fails to completely parse the JSON body. The
    /// options are
    /// the following:
    ///
    /// * `EVALUATE_AS_STRING` - Inspect the body as plain text. WAF
    /// applies the text transformations and inspection criteria that you defined
    /// for the
    /// JSON inspection to the body text string.
    ///
    /// * `MATCH` - Treat the web request as matching the rule statement.
    /// WAF applies the rule action to the request.
    ///
    /// * `NO_MATCH` - Treat the web request as not matching the rule
    /// statement.
    ///
    /// If you don't provide this setting, WAF parses and evaluates the content only
    /// up to the
    /// first parsing failure that it encounters.
    ///
    /// Example JSON: `{ "UriFragment": { "FallbackBehavior": "MATCH"} }`
    ///
    /// WAF parsing doesn't fully validate the input JSON string, so parsing can
    /// succeed even for invalid JSON. When
    /// parsing succeeds, WAF doesn't apply the fallback behavior. For more
    /// information,
    /// see [JSON
    /// body](https://docs.aws.amazon.com/waf/latest/developerguide/waf-rule-statement-fields-list.html#waf-rule-statement-request-component-json-body)
    /// in the *WAF Developer Guide*.
    fallback_behavior: ?FallbackBehavior,

    pub const json_field_names = .{
        .fallback_behavior = "FallbackBehavior",
    };
};
