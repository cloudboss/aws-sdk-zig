const Category = @import("category.zig").Category;

/// Indicates if the access location is restricted. Index correlates to that of
/// an access point and indicates if access through this point has some form of
/// restriction.
pub const AccessRestriction = struct {
    /// Categories of results that results must belong too.
    categories: ?[]const Category,

    /// The restriction.
    restricted: ?bool,

    pub const json_field_names = .{
        .categories = "Categories",
        .restricted = "Restricted",
    };
};
