/// Allows you to define the structure for modifying specific fields in security
/// findings.
pub const AutomationRulesFindingFieldsUpdateV2 = struct {
    /// Notes or contextual information for findings that are modified by the
    /// automation rule.
    comment: ?[]const u8 = null,

    /// The severity level to be assigned to findings that match the automation rule
    /// criteria.
    severity_id: ?i32 = null,

    /// The status to be applied to findings that match automation rule criteria.
    status_id: ?i32 = null,

    pub const json_field_names = .{
        .comment = "Comment",
        .severity_id = "SeverityId",
        .status_id = "StatusId",
    };
};
