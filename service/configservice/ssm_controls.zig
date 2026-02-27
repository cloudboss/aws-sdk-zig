/// Amazon Web Services Systems Manager (SSM) specific remediation controls.
pub const SsmControls = struct {
    /// The maximum percentage of remediation actions allowed to run in parallel on
    /// the non-compliant resources for that specific rule. You can specify a
    /// percentage, such as 10%. The default value is 10.
    concurrent_execution_rate_percentage: ?i32,

    /// The percentage of errors that are allowed before SSM stops running
    /// automations on non-compliant resources for that specific rule.
    /// You can specify a percentage of errors, for example 10%. If you do not
    /// specifiy a percentage, the default is 50%.
    /// For example, if you set the ErrorPercentage to 40% for 10 non-compliant
    /// resources, then SSM stops running the automations when the fifth error is
    /// received.
    error_percentage: ?i32,

    pub const json_field_names = .{
        .concurrent_execution_rate_percentage = "ConcurrentExecutionRatePercentage",
        .error_percentage = "ErrorPercentage",
    };
};
