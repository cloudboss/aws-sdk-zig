const QuerySuggestionsBlockListStatus = @import("query_suggestions_block_list_status.zig").QuerySuggestionsBlockListStatus;

/// Summary information on a query suggestions block list.
///
/// This includes information on the block list ID, block list name, when the
/// block list was created, when the block list was last updated, and the count
/// of block words/phrases in the block list.
///
/// For information on the current quota limits for block lists, see
/// [Quotas
/// for Amazon
/// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
pub const QuerySuggestionsBlockListSummary = struct {
    /// The Unix timestamp when the block list was created.
    created_at: ?i64 = null,

    /// The identifier of a block list.
    id: ?[]const u8 = null,

    /// The number of items in the block list file.
    item_count: ?i32 = null,

    /// The name of the block list.
    name: ?[]const u8 = null,

    /// The status of the block list.
    status: ?QuerySuggestionsBlockListStatus = null,

    /// The Unix timestamp when the block list was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .id = "Id",
        .item_count = "ItemCount",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};
