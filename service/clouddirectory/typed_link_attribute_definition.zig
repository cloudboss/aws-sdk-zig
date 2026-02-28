const aws = @import("aws");

const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;
const RequiredAttributeBehavior = @import("required_attribute_behavior.zig").RequiredAttributeBehavior;
const Rule = @import("rule.zig").Rule;
const FacetAttributeType = @import("facet_attribute_type.zig").FacetAttributeType;

/// A typed link attribute definition.
pub const TypedLinkAttributeDefinition = struct {
    /// The default value of the attribute (if configured).
    default_value: ?TypedAttributeValue,

    /// Whether the attribute is mutable or not.
    is_immutable: bool = false,

    /// The unique name of the typed link attribute.
    name: []const u8,

    /// The required behavior of the `TypedLinkAttributeDefinition`.
    required_behavior: RequiredAttributeBehavior,

    /// Validation rules that are attached to the attribute definition.
    rules: ?[]const aws.map.MapEntry(Rule),

    /// The type of the attribute.
    @"type": FacetAttributeType,

    pub const json_field_names = .{
        .default_value = "DefaultValue",
        .is_immutable = "IsImmutable",
        .name = "Name",
        .required_behavior = "RequiredBehavior",
        .rules = "Rules",
        .@"type" = "Type",
    };
};
