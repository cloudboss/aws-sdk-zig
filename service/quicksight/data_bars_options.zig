/// The options for data bars.
pub const DataBarsOptions = struct {
    /// The field ID for the data bars options.
    field_id: []const u8,

    /// The color of the negative data bar.
    negative_color: ?[]const u8,

    /// The color of the positive data bar.
    positive_color: ?[]const u8,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .negative_color = "NegativeColor",
        .positive_color = "PositiveColor",
    };
};
