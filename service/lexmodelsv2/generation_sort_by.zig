const GenerationSortByAttribute = @import("generation_sort_by_attribute.zig").GenerationSortByAttribute;
const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies the attribute and method by which to sort the generation request
/// information.
pub const GenerationSortBy = struct {
    /// The attribute by which to sort the generation request information. You can
    /// sort by the following attributes.
    ///
    /// * `creationStartTime` – The time at which the generation request was
    ///   created.
    ///
    /// * `lastUpdatedTime` – The time at which the generation request was last
    ///   updated.
    attribute: GenerationSortByAttribute,

    /// The order by which to sort the generation request information.
    order: SortOrder,

    pub const json_field_names = .{
        .attribute = "attribute",
        .order = "order",
    };
};
