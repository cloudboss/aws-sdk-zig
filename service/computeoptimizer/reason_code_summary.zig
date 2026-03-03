const FindingReasonCode = @import("finding_reason_code.zig").FindingReasonCode;

/// A summary of a finding reason code.
pub const ReasonCodeSummary = struct {
    /// The name of the finding reason code.
    name: ?FindingReasonCode = null,

    /// The value of the finding reason code summary.
    value: f64 = 0,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
