/// The custom narrative options.
pub const CustomNarrativeOptions = struct {
    /// The string input of custom narrative.
    narrative: []const u8,

    pub const json_field_names = .{
        .narrative = "Narrative",
    };
};
