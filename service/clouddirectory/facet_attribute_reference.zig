/// The facet attribute reference that specifies the attribute definition that
/// contains the
/// attribute facet name and attribute name.
pub const FacetAttributeReference = struct {
    /// The target attribute name that is associated with the facet reference. See
    /// [Attribute
    /// References](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_attributereferences.html) for more information.
    target_attribute_name: []const u8,

    /// The target facet name that is associated with the facet reference. See
    /// [Attribute
    /// References](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_attributereferences.html) for more information.
    target_facet_name: []const u8,

    pub const json_field_names = .{
        .target_attribute_name = "TargetAttributeName",
        .target_facet_name = "TargetFacetName",
    };
};
