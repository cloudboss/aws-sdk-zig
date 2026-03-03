const LFTagPair = @import("lf_tag_pair.zig").LFTagPair;
const ColumnLFTag = @import("column_lf_tag.zig").ColumnLFTag;
const TableResource = @import("table_resource.zig").TableResource;

/// A structure describing a table resource with LF-tags.
pub const TaggedTable = struct {
    /// A list of LF-tags attached to the database where the table resides.
    lf_tag_on_database: ?[]const LFTagPair = null,

    /// A list of LF-tags attached to columns in the table.
    lf_tags_on_columns: ?[]const ColumnLFTag = null,

    /// A list of LF-tags attached to the table.
    lf_tags_on_table: ?[]const LFTagPair = null,

    /// A table that has LF-tags attached to it.
    table: ?TableResource = null,

    pub const json_field_names = .{
        .lf_tag_on_database = "LFTagOnDatabase",
        .lf_tags_on_columns = "LFTagsOnColumns",
        .lf_tags_on_table = "LFTagsOnTable",
        .table = "Table",
    };
};
