const TypedLinkAttributeRange = @import("typed_link_attribute_range.zig").TypedLinkAttributeRange;
const TypedLinkSchemaAndFacetName = @import("typed_link_schema_and_facet_name.zig").TypedLinkSchemaAndFacetName;
const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Returns a paginated list of all the outgoing TypedLinkSpecifier information
/// for an object inside a BatchRead operation. For more information, see
/// ListOutgoingTypedLinks and BatchReadRequest$Operations.
pub const BatchListOutgoingTypedLinks = struct {
    /// Provides range filters for multiple attributes. When providing ranges to
    /// typed link
    /// selection, any inexact ranges must be specified at the end. Any attributes
    /// that do not have a
    /// range specified are presumed to match the entire range.
    filter_attribute_ranges: ?[]const TypedLinkAttributeRange = null,

    /// Filters are interpreted in the order of the attributes defined on the typed
    /// link facet,
    /// not the order they are supplied to any API calls.
    filter_typed_link: ?TypedLinkSchemaAndFacetName = null,

    /// The maximum number of results to retrieve.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// The reference that identifies the object whose attributes will be listed.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .filter_attribute_ranges = "FilterAttributeRanges",
        .filter_typed_link = "FilterTypedLink",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};
