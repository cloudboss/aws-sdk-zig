/// Used as the request parameter in the ListAssessmentTargets
/// action.
pub const AssessmentTargetFilter = struct {
    /// For a record to match a filter, an explicit value or a string that contains
    /// a
    /// wildcard that is specified for this data type property must match the value
    /// of the
    /// **assessmentTargetName** property of the AssessmentTarget data type.
    assessment_target_name_pattern: ?[]const u8,

    pub const json_field_names = .{
        .assessment_target_name_pattern = "assessmentTargetNamePattern",
    };
};
