/// A description of each select option.
pub const SelectOptionDescription = struct {
    /// A description of the option meaning.
    description: ?[]const u8 = null,

    /// The value of the option.
    option: []const u8,

    /// The title of the select option.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .option = "Option",
        .title = "Title",
    };
};
