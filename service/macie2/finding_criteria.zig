const aws = @import("aws");

const CriterionAdditionalProperties = @import("criterion_additional_properties.zig").CriterionAdditionalProperties;

/// Specifies, as a map, one or more property-based conditions that filter the
/// results of a query for findings.
pub const FindingCriteria = struct {
    /// A condition that specifies the property, operator, and one or more values to
    /// use to filter the results.
    criterion: ?[]const aws.map.MapEntry(CriterionAdditionalProperties),

    pub const json_field_names = .{
        .criterion = "criterion",
    };
};
