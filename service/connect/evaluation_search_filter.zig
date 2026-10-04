const ControlPlaneAttributeFilter = @import("control_plane_attribute_filter.zig").ControlPlaneAttributeFilter;
const ContactEvaluationAttributeFilter = @import("contact_evaluation_attribute_filter.zig").ContactEvaluationAttributeFilter;

/// Filters to be applied to search results.
pub const EvaluationSearchFilter = struct {
    /// An object that can be used to specify tag conditions.
    attribute_filter: ?ControlPlaneAttributeFilter = null,

    /// An object that can be used to specify tag conditions and attribute
    /// conditions for contact evaluations.
    contact_evaluation_attribute_filter: ?ContactEvaluationAttributeFilter = null,

    pub const json_field_names = .{
        .attribute_filter = "AttributeFilter",
        .contact_evaluation_attribute_filter = "ContactEvaluationAttributeFilter",
    };
};
