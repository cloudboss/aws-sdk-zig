const AnalyticsSessionField = @import("analytics_session_field.zig").AnalyticsSessionField;

/// Contains the category by which to group the sessions.
pub const AnalyticsSessionGroupBySpecification = struct {
    /// Specifies whether to group the session by their end state or their locale.
    name: AnalyticsSessionField,

    pub const json_field_names = .{
        .name = "name",
    };
};
