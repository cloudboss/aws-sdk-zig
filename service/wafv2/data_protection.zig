const DataProtectionAction = @import("data_protection_action.zig").DataProtectionAction;
const FieldToProtect = @import("field_to_protect.zig").FieldToProtect;

/// Specifies the protection behavior for a field type. This is part of the data
/// protection configuration for a web ACL.
pub const DataProtection = struct {
    /// Specifies how to protect the field. WAF can apply a one-way hash to the
    /// field or hard code a string substitution.
    ///
    /// * One-way hash example:
    ///   `ade099751dEXAMPLEHASH2ea9f3393f80dd5d3bEXAMPLEHASH966ae0d3cd5a1e`
    ///
    /// * Substitution example: `REDACTED`
    action: DataProtectionAction,

    /// Specifies whether to also exclude any rate-based rule details from the data
    /// protection you have enabled for a given field. If you specify this
    /// exception, RateBasedDetails will show the value of the field.
    /// For additional information, see the log field `rateBasedRuleList` at
    /// [Log fields for web ACL
    /// traffic](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html) in the
    /// *WAF Developer Guide*.
    ///
    /// Default: `FALSE`
    exclude_rate_based_details: bool = false,

    /// Specifies whether to also exclude any rule match details from the data
    /// protection you have enabled for a given field. WAF logs these details for
    /// non-terminating
    /// matching rules and for the terminating matching rule. For additional
    /// information, see
    /// [Log fields for web ACL
    /// traffic](https://docs.aws.amazon.com/waf/latest/developerguide/logging-fields.html) in the
    /// *WAF Developer Guide*.
    ///
    /// Default: `FALSE`
    exclude_rule_match_details: bool = false,

    /// Specifies the field type and optional keys to apply the protection behavior
    /// to.
    field: FieldToProtect,

    pub const json_field_names = .{
        .action = "Action",
        .exclude_rate_based_details = "ExcludeRateBasedDetails",
        .exclude_rule_match_details = "ExcludeRuleMatchDetails",
        .field = "Field",
    };
};
