/// The bookmarks configuration of an embedded dashboard.
pub const BookmarksConfigurations = struct {
    /// A Boolean value that determines whether a user
    /// can bookmark an embedded dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
