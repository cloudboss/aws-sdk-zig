const Category = @import("category.zig").Category;
const OpeningHoursComponents = @import("opening_hours_components.zig").OpeningHoursComponents;

/// List of opening hours objects.
pub const OpeningHours = struct {
    /// Categories of results that results must belong too.
    categories: ?[]const Category = null,

    /// Components of the opening hours object.
    components: ?[]const OpeningHoursComponents = null,

    /// List of opening hours in the format they are displayed in. This can vary by
    /// result and in most cases represents how the result uniquely formats their
    /// opening hours.
    display: ?[]const []const u8 = null,

    /// Boolean which indicates if the result/place is currently open.
    open_now: ?bool = null,

    pub const json_field_names = .{
        .categories = "Categories",
        .components = "Components",
        .display = "Display",
        .open_now = "OpenNow",
    };
};
