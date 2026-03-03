const ComplianceType = @import("compliance_type.zig").ComplianceType;

/// Identifies an Amazon Web Services resource and indicates whether it complies
/// with the Config rule that it was evaluated against.
pub const ExternalEvaluation = struct {
    /// Supplementary information about the reason of compliance. For example, this
    /// task was completed on a specific date.
    annotation: ?[]const u8 = null,

    /// The evaluated compliance resource ID. Config accepts only Amazon Web
    /// Services account ID.
    compliance_resource_id: []const u8,

    /// The evaluated compliance resource type. Config accepts `AWS::::Account`
    /// resource type.
    compliance_resource_type: []const u8,

    /// The compliance of the Amazon Web Services resource. The valid values are
    /// `COMPLIANT, NON_COMPLIANT, ` and `NOT_APPLICABLE`.
    compliance_type: ComplianceType,

    /// The time when the compliance was recorded.
    ordering_timestamp: i64,

    pub const json_field_names = .{
        .annotation = "Annotation",
        .compliance_resource_id = "ComplianceResourceId",
        .compliance_resource_type = "ComplianceResourceType",
        .compliance_type = "ComplianceType",
        .ordering_timestamp = "OrderingTimestamp",
    };
};
