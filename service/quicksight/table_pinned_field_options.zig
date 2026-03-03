/// The settings for the pinned columns of a table visual.
pub const TablePinnedFieldOptions = struct {
    /// A list of columns to be pinned to the left of a table visual.
    pinned_left_fields: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .pinned_left_fields = "PinnedLeftFields",
    };
};
