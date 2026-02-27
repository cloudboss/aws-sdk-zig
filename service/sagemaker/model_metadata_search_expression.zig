const ModelMetadataFilter = @import("model_metadata_filter.zig").ModelMetadataFilter;

/// One or more filters that searches for the specified resource or resources in
/// a search. All resource objects that satisfy the expression's condition are
/// included in the search results
pub const ModelMetadataSearchExpression = struct {
    /// A list of filter objects.
    filters: ?[]const ModelMetadataFilter,

    pub const json_field_names = .{
        .filters = "Filters",
    };
};
