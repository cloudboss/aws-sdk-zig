const IngressAnalysis = @import("ingress_analysis.zig").IngressAnalysis;
const IngressStringEmailAttribute = @import("ingress_string_email_attribute.zig").IngressStringEmailAttribute;

/// The union type representing the allowed types for the left hand side of a
/// string condition.
pub const IngressStringToEvaluate = union(enum) {
    /// The structure type for a string condition stating the Add On ARN and its
    /// returned value.
    analysis: ?IngressAnalysis,
    /// The enum type representing the allowed attribute types for a string
    /// condition.
    attribute: ?IngressStringEmailAttribute,

    pub const json_field_names = .{
        .analysis = "Analysis",
        .attribute = "Attribute",
    };
};
