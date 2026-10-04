const WafFailureMode = @import("waf_failure_mode.zig").WafFailureMode;

/// The Amazon Web Services WAF configuration for the gateway. This
/// configuration controls how the gateway behaves when the associated web ACL
/// cannot be evaluated.
pub const WafConfiguration = struct {
    /// The failure mode that determines how the gateway handles requests when
    /// Amazon Web Services WAF is unreachable or times out. Valid values include:
    ///
    /// * `FAIL_CLOSE` - The gateway blocks requests when Amazon Web Services WAF
    ///   cannot be evaluated.
    /// * `FAIL_OPEN` - The gateway allows requests when Amazon Web Services WAF
    ///   cannot be evaluated.
    failure_mode: ?WafFailureMode = null,

    pub const json_field_names = .{
        .failure_mode = "failureMode",
    };
};
