/// Information about the dataset whose content generation triggers the new
/// dataset content
/// generation.
pub const TriggeringDataset = struct {
    /// The name of the dataset whose content generation triggers the new dataset
    /// content
    /// generation.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
