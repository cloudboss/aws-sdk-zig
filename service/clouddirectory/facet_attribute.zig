const FacetAttributeDefinition = @import("facet_attribute_definition.zig").FacetAttributeDefinition;
const FacetAttributeReference = @import("facet_attribute_reference.zig").FacetAttributeReference;
const RequiredAttributeBehavior = @import("required_attribute_behavior.zig").RequiredAttributeBehavior;

/// An attribute that is associated with the Facet.
pub const FacetAttribute = struct {
    /// A facet attribute consists of either a definition or a reference. This
    /// structure
    /// contains the attribute definition. See [Attribute
    /// References](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_attributereferences.html) for more information.
    attribute_definition: ?FacetAttributeDefinition = null,

    /// An attribute reference that is associated with the attribute. See [Attribute
    /// References](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_attributereferences.html) for more information.
    attribute_reference: ?FacetAttributeReference = null,

    /// The name of the facet attribute.
    name: []const u8,

    /// The required behavior of the `FacetAttribute`.
    required_behavior: ?RequiredAttributeBehavior = null,

    pub const json_field_names = .{
        .attribute_definition = "AttributeDefinition",
        .attribute_reference = "AttributeReference",
        .name = "Name",
        .required_behavior = "RequiredBehavior",
    };
};
