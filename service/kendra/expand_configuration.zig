/// Specifies the configuration information needed to customize how collapsed
/// search
/// result groups expand.
pub const ExpandConfiguration = struct {
    /// The number of expanded results to show per collapsed primary document. For
    /// instance,
    /// if you set this value to 3, then at most 3 results per collapsed group will
    /// be
    /// displayed.
    max_expanded_results_per_item: ?i32 = null,

    /// The number of collapsed search result groups to expand. If you set this
    /// value to 10,
    /// for example, only the first 10 out of 100 result groups will have expand
    /// functionality.
    max_result_items_to_expand: ?i32 = null,

    pub const json_field_names = .{
        .max_expanded_results_per_item = "MaxExpandedResultsPerItem",
        .max_result_items_to_expand = "MaxResultItemsToExpand",
    };
};
