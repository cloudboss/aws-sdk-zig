const ElementRequirement = @import("element_requirement.zig").ElementRequirement;

/// Defines a validation rule that modifies the requirement status of a specific
/// X12 element within a segment. This rule allows you to make optional elements
/// mandatory or mandatory elements optional, providing flexibility to
/// accommodate different trading partner requirements and business rules. The
/// rule targets a specific element position within a segment and sets its
/// requirement status to either OPTIONAL or MANDATORY.
pub const X12ElementRequirementValidationRule = struct {
    /// Specifies the position of the element within an X12 segment for which the
    /// requirement status will be modified. The format follows the pattern of
    /// segment identifier followed by element position (e.g., "ST-01" for the first
    /// element of the ST segment).
    element_position: []const u8,

    /// Specifies the requirement status for the element at the specified position.
    /// Valid values are OPTIONAL (the element may be omitted) or MANDATORY (the
    /// element must be present).
    requirement: ElementRequirement,

    pub const json_field_names = .{
        .element_position = "elementPosition",
        .requirement = "requirement",
    };
};
