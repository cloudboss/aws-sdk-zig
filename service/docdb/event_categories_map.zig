/// An event source type, accompanied by one or more event category names.
pub const EventCategoriesMap = struct {
    /// The event categories for the specified source type.
    event_categories: ?[]const []const u8 = null,

    /// The source type that the returned categories belong to.
    source_type: ?[]const u8 = null,
};
