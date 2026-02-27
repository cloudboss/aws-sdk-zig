/// Represents item metadata added to an Items dataset using the
/// `PutItems` API. For more information see
/// [Importing items
/// individually](https://docs.aws.amazon.com/personalize/latest/dg/importing-items.html).
pub const Item = struct {
    /// The ID associated with the item.
    item_id: []const u8,

    /// A string map of item-specific metadata. Each element in the map consists of
    /// a key-value pair.
    /// For example, `{"numberOfRatings": "12"}`.
    ///
    /// The keys use camel case names that match the fields in the schema for the
    /// Items
    /// dataset. In the previous example, the `numberOfRatings` matches the
    /// 'NUMBER_OF_RATINGS' field defined in the Items schema. For categorical
    /// string data, to include multiple categories for a single item,
    /// separate each category with a pipe separator (`|`). For example,
    /// `\"Horror|Action\"`.
    properties: ?[]const u8,

    pub const json_field_names = .{
        .item_id = "itemId",
        .properties = "properties",
    };
};
