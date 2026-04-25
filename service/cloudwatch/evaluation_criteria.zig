const AlarmPromQLCriteria = @import("alarm_prom_ql_criteria.zig").AlarmPromQLCriteria;

/// The evaluation criteria for an alarm. This is a union type that currently
/// supports `PromQLCriteria`.
pub const EvaluationCriteria = union(enum) {
    /// The PromQL criteria for the alarm evaluation.
    prom_ql_criteria: ?AlarmPromQLCriteria,

    pub const json_field_names = .{
        .prom_ql_criteria = "PromQLCriteria",
    };
};
