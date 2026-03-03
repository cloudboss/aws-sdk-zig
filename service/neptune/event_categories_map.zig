/// Contains the results of a successful invocation of the
/// DescribeEventCategories action.
pub const EventCategoriesMap = struct {
    /// The event categories for the specified source type
    event_categories: ?[]const []const u8 = null,

    /// The source type that the returned categories belong to
    source_type: ?[]const u8 = null,
};
