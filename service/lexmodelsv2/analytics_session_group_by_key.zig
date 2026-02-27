const AnalyticsSessionField = @import("analytics_session_field.zig").AnalyticsSessionField;

/// Contains the category by which the session analytics were grouped and a
/// member of that category.
pub const AnalyticsSessionGroupByKey = struct {
    /// The category by which the session analytics were grouped.
    name: ?AnalyticsSessionField,

    /// A member of the category by which the session analytics were grouped.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
