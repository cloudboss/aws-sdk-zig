const ComplianceType = @import("compliance_type.zig").ComplianceType;

/// Identifies an Amazon Web Services resource and indicates whether it complies
/// with the Config rule that it was evaluated against.
pub const Evaluation = struct {
    /// Supplementary information about how the evaluation determined
    /// the compliance.
    annotation: ?[]const u8 = null,

    /// The ID of the Amazon Web Services resource that was evaluated.
    compliance_resource_id: []const u8,

    /// The type of Amazon Web Services resource that was evaluated.
    compliance_resource_type: []const u8,

    /// Indicates whether the Amazon Web Services resource complies with the Config
    /// rule that it was evaluated against.
    ///
    /// For the `Evaluation` data type, Config supports
    /// only the `COMPLIANT`, `NON_COMPLIANT`, and
    /// `NOT_APPLICABLE` values. Config does not support
    /// the `INSUFFICIENT_DATA` value for this data
    /// type.
    ///
    /// Similarly, Config does not accept
    /// `INSUFFICIENT_DATA` as the value for
    /// `ComplianceType` from a `PutEvaluations`
    /// request. For example, an Lambda function for a custom Config
    /// rule cannot pass an `INSUFFICIENT_DATA` value to Config.
    compliance_type: ComplianceType,

    /// The time of the event in Config that triggered the
    /// evaluation. For event-based evaluations, the time indicates when Config
    /// created the configuration item that triggered the evaluation.
    /// For periodic evaluations, the time indicates when Config
    /// triggered the evaluation at the frequency that you specified (for
    /// example, every 24 hours).
    ordering_timestamp: i64,

    pub const json_field_names = .{
        .annotation = "Annotation",
        .compliance_resource_id = "ComplianceResourceId",
        .compliance_resource_type = "ComplianceResourceType",
        .compliance_type = "ComplianceType",
        .ordering_timestamp = "OrderingTimestamp",
    };
};
