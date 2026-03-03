const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;

/// Returns a filtered list of Detective or Proactive Config rules. By default,
/// if the filter is not defined, this API returns an unfiltered list. For more
/// information on Detective or Proactive Config rules,
/// see [
/// **Evaluation Mode**
/// ](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config-rules.html) in the *Config Developer Guide*.
pub const DescribeConfigRulesFilters = struct {
    /// The mode of an evaluation. The valid values are Detective or Proactive.
    evaluation_mode: ?EvaluationMode = null,

    pub const json_field_names = .{
        .evaluation_mode = "EvaluationMode",
    };
};
