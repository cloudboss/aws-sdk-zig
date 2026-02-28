const aws = @import("aws");

const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;
const Rule = @import("rule.zig").Rule;
const FacetAttributeType = @import("facet_attribute_type.zig").FacetAttributeType;

/// A facet attribute definition. See [Attribute
/// References](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_attributereferences.html) for more information.
pub const FacetAttributeDefinition = struct {
    /// The default value of the attribute (if configured).
    default_value: ?TypedAttributeValue,

    /// Whether the attribute is mutable or not.
    is_immutable: bool = false,

    /// Validation rules attached to the attribute definition.
    rules: ?[]const aws.map.MapEntry(Rule),

    /// The type of the attribute.
    type: FacetAttributeType,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .is_immutable = "IsImmutable",
        .rules = "Rules",
        .type = "Type",
    };
};
