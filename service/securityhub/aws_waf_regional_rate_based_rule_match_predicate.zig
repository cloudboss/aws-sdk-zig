/// Details for a match predicate. A predicate might look for characteristics
/// such as specific IP addresses, geographic locations, or sizes.
pub const AwsWafRegionalRateBasedRuleMatchPredicate = struct {
    /// The unique identifier for the predicate.
    data_id: ?[]const u8 = null,

    /// If set to `true`, then the rule actions are performed on requests that match
    /// the predicate settings.
    ///
    /// If set to `false`, then the rule actions are performed on all requests
    /// except those that match the predicate settings.
    negated: ?bool = null,

    /// The type of predicate. Valid values are as follows:
    ///
    /// * `ByteMatch`
    ///
    /// * `GeoMatch`
    ///
    /// * `IPMatch`
    ///
    /// * `RegexMatch`
    ///
    /// * `SizeConstraint`
    ///
    /// * `SqlInjectionMatch`
    ///
    /// * `XssMatch`
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .data_id = "DataId",
        .negated = "Negated",
        .@"type" = "Type",
    };
};
