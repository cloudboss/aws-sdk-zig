const DurationRange = @import("duration_range.zig").DurationRange;

/// Used as the request parameter in the ListAssessmentTemplates
/// action.
pub const AssessmentTemplateFilter = struct {
    /// For a record to match a filter, the value specified for this data type
    /// property must
    /// inclusively match any value between the specified minimum and maximum values
    /// of the
    /// **durationInSeconds** property of the AssessmentTemplate data type.
    duration_range: ?DurationRange = null,

    /// For a record to match a filter, an explicit value or a string that contains
    /// a
    /// wildcard that is specified for this data type property must match the value
    /// of the
    /// **assessmentTemplateName** property of the AssessmentTemplate data type.
    name_pattern: ?[]const u8 = null,

    /// For a record to match a filter, the values that are specified for this data
    /// type
    /// property must be contained in the list of values of the **rulesPackageArns**
    /// property of the AssessmentTemplate data
    /// type.
    rules_package_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .duration_range = "durationRange",
        .name_pattern = "namePattern",
        .rules_package_arns = "rulesPackageArns",
    };
};
