const DataRetrievalRule = @import("data_retrieval_rule.zig").DataRetrievalRule;

/// Data retrieval policy.
pub const DataRetrievalPolicy = struct {
    /// The policy rule. Although this is a list type, currently there must be only
    /// one rule,
    /// which contains a Strategy field and optionally a BytesPerHour field.
    rules: ?[]const DataRetrievalRule,

    pub const json_field_names = .{
        .rules = "Rules",
    };
};
