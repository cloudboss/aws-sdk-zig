const OversizeHandling = @import("oversize_handling.zig").OversizeHandling;

/// Inspect a string containing the list of the request's header names, ordered
/// as they appear in the web request
/// that WAF receives for inspection.
/// WAF generates the string and then uses that as the field to match component
/// in its inspection.
/// WAF separates the header names in the string using colons and no added
/// spaces, for example `host:user-agent:accept:authorization:referer`.
pub const HeaderOrder = struct {
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
        .oversize_handling = "OversizeHandling",
    };
};
