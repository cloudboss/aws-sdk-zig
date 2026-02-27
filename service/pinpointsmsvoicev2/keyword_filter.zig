const KeywordFilterName = @import("keyword_filter_name.zig").KeywordFilterName;

/// The information for keywords that meet a specified criteria.
pub const KeywordFilter = struct {
    /// The name of the attribute to filter on.
    name: KeywordFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
