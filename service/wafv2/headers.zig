const HeaderMatchPattern = @import("header_match_pattern.zig").HeaderMatchPattern;
const MapMatchScope = @import("map_match_scope.zig").MapMatchScope;
const OversizeHandling = @import("oversize_handling.zig").OversizeHandling;

/// Inspect all headers in the web request. You can specify the parts of the
/// headers to
/// inspect and you can narrow the set of headers to inspect by including or
/// excluding specific
/// keys.
///
/// This is used to indicate the web request component to inspect, in the
/// FieldToMatch specification.
///
/// If you want to inspect just the value of a single header, use the
/// `SingleHeader`
/// `FieldToMatch` setting instead.
///
/// Example JSON: `"Headers": { "MatchPattern": { "All": {} }, "MatchScope":
/// "KEY",
/// "OversizeHandling": "MATCH" }`
pub const Headers = struct {
    /// The filter to use to identify the subset of headers to inspect in a web
    /// request.
    ///
    /// You must specify exactly one setting: either `All`, `IncludedHeaders`, or
    /// `ExcludedHeaders`.
    ///
    /// Example JSON: `"MatchPattern": { "ExcludedHeaders": [ "KeyToExclude1",
    /// "KeyToExclude2" ] }`
    match_pattern: HeaderMatchPattern,

    /// The parts of the headers to match with the rule inspection criteria. If you
    /// specify
    /// `ALL`, WAF inspects both keys and values.
    ///
    /// `All` does not require a match to be found in the keys
    /// and a match to be found in the values. It requires a match to be found in
    /// the keys
    /// or the values or both. To require a match in the keys and in the values, use
    /// a logical `AND` statement
    /// to combine two match rules, one that inspects the keys and another that
    /// inspects the values.
    match_scope: MapMatchScope,

    /// What WAF should do if the headers determined by your match scope are more
    /// numerous or larger than WAF can inspect.
    /// WAF does not support inspecting the entire contents of request headers
    /// when they exceed 8 KB (8192 bytes) or 200 total headers. The underlying host
    /// service forwards a maximum of 200 headers
    /// and at most 8 KB of header contents to WAF.
    ///
    /// The options for oversize handling are the following:
    ///
    /// * `CONTINUE` - Inspect the available headers normally, according to the rule
    ///   inspection criteria.
    ///
    /// * `MATCH` - Treat the web request as matching the rule statement. WAF
    /// applies the rule action to the request.
    ///
    /// * `NO_MATCH` - Treat the web request as not matching the rule
    /// statement.
    oversize_handling: OversizeHandling,

    pub const json_field_names = .{
        .match_pattern = "MatchPattern",
        .match_scope = "MatchScope",
        .oversize_handling = "OversizeHandling",
    };
};
