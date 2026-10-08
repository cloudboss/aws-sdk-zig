const aws = @import("aws");

const EksLabelSelectorRequirement = @import("eks_label_selector_requirement.zig").EksLabelSelectorRequirement;

/// A label selector that filters the Kubernetes objects discovered from an
/// Amazon EKS input source. An object must satisfy both matchLabels and
/// matchExpressions to match the selector. A selector with neither matches
/// every object. The selector must render to 2,048 characters or fewer in
/// Kubernetes label selector syntax.
pub const EksLabelSelector = struct {
    /// The label requirements that an object must satisfy. All requirements in the
    /// list must match for the object to be selected.
    match_expressions: ?[]const EksLabelSelectorRequirement = null,

    /// The label key-value pairs that an object must have. All pairs must match for
    /// the object to be selected.
    match_labels: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .match_expressions = "matchExpressions",
        .match_labels = "matchLabels",
    };
};
