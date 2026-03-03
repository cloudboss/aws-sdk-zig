/// Details about the action that CloudFront or WAF takes when a web request
/// matches the
/// conditions in the rule.
pub const WafAction = struct {
    /// Specifies how you want WAF to respond to requests that match the settings in
    /// a
    /// rule.
    ///
    /// Valid settings include the following:
    ///
    /// * `ALLOW` - WAF allows requests
    ///
    /// * `BLOCK` - WAF blocks requests
    ///
    /// * `COUNT` - WAF increments a counter of the requests that
    /// match all of the conditions in the rule. WAF then continues to inspect
    /// the web request based on the remaining rules in the web ACL. You can't
    /// specify
    /// `COUNT` for the default action for a web ACL.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
