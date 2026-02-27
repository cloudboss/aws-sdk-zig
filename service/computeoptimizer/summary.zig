const Finding = @import("finding.zig").Finding;
const ReasonCodeSummary = @import("reason_code_summary.zig").ReasonCodeSummary;

/// The summary of a recommendation.
pub const Summary = struct {
    /// The finding classification of the recommendation.
    name: ?Finding,

    /// An array of objects that summarize a finding reason code.
    reason_code_summaries: ?[]const ReasonCodeSummary,

    /// The value of the recommendation summary.
    value: f64 = 0,

    pub const json_field_names = .{
        .name = "name",
        .reason_code_summaries = "reasonCodeSummaries",
        .value = "value",
    };
};
