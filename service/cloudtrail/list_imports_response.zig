const ImportsListItem = @import("imports_list_item.zig").ImportsListItem;

pub const ListImportsResponse = struct {
    /// The list of returned imports.
    imports: ?[]const ImportsListItem,

    /// A token you can use to get the next page of import results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .imports = "Imports",
        .next_token = "NextToken",
    };
};
