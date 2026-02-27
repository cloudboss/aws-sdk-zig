/// An enumerated type that determines how the evaluated rules are processed.
/// RuleType can be one of the following:
///
/// ATLEAST - At least N routing controls must be set. You specify N as the
/// Threshold in the rule configuration.
///
/// AND - All routing controls must be set. This is a shortcut for "At least N,"
/// where N is the total number of controls in the rule.
///
/// OR - Any control must be set. This is a shortcut for "At least N," where N
/// is 1.
pub const RuleType = enum {
    atleast,
    @"and",
    @"or",

    pub const json_field_names = .{
        .atleast = "ATLEAST",
        .@"and" = "AND",
        .@"or" = "OR",
    };
};
