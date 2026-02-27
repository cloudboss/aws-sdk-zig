const LFTag = @import("lf_tag.zig").LFTag;

/// A structure consists LF-Tag expression name and catalog ID.
pub const LFTagExpression = struct {
    /// The identifier for the Data Catalog. By default, the account ID.
    catalog_id: ?[]const u8,

    /// A structure that contains information about the LF-Tag expression.
    description: ?[]const u8,

    /// A logical expression composed of one or more LF-Tags.
    expression: ?[]const LFTag,

    /// The name for saved the LF-Tag expression.
    name: ?[]const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .description = "Description",
        .expression = "Expression",
        .name = "Name",
    };
};
