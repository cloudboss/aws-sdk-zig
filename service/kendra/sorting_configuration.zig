const SortOrder = @import("sort_order.zig").SortOrder;

/// Specifies the document attribute to use to sort the response to a Amazon
/// Kendra
/// query. You can specify a single attribute for sorting. The attribute must
/// have the
/// `Sortable` flag set to `true`, otherwise Amazon Kendra
/// returns an exception.
///
/// You can sort attributes of the following types.
///
/// * Date value
///
/// * Long value
///
/// * String value
///
/// You can't sort attributes of the following type.
///
/// * String list value
pub const SortingConfiguration = struct {
    /// The name of the document attribute used to sort the response. You can use
    /// any field
    /// that has the `Sortable` flag set to true.
    ///
    /// You can also sort by any of the following built-in attributes:
    ///
    /// * _category
    ///
    /// * _created_at
    ///
    /// * _last_updated_at
    ///
    /// * _version
    ///
    /// * _view_count
    document_attribute_key: []const u8,

    /// The order that the results should be returned in. In case of ties, the
    /// relevance
    /// assigned to the result by Amazon Kendra is used as the tie-breaker.
    sort_order: SortOrder,

    pub const json_field_names = .{
        .document_attribute_key = "DocumentAttributeKey",
        .sort_order = "SortOrder",
    };
};
