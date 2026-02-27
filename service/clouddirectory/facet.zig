const FacetStyle = @import("facet_style.zig").FacetStyle;
const ObjectType = @import("object_type.zig").ObjectType;

/// A structure that contains `Name`, `ARN`, `Attributes`, `
/// Rules`, and
/// `ObjectTypes`. See
/// [Facets](https://docs.aws.amazon.com/clouddirectory/latest/developerguide/schemas_whatarefacets.html) for more information.
pub const Facet = struct {
    /// There are two different styles that you can define on any given facet,
    /// `Static` and `Dynamic`. For static facets, all attributes must be defined in
    /// the schema. For dynamic facets, attributes can be defined during data plane
    /// operations.
    facet_style: ?FacetStyle,

    /// The name of the Facet.
    name: ?[]const u8,

    /// The object type that is associated with the facet. See
    /// CreateFacetRequest$ObjectType for more details.
    object_type: ?ObjectType,

    pub const json_field_names = .{
        .facet_style = "FacetStyle",
        .name = "Name",
        .object_type = "ObjectType",
    };
};
