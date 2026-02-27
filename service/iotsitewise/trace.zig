/// Contains tracing information of the SiteWise Assistant's reasoning and data
/// access.
pub const Trace = struct {
    /// The cited text from the data source.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
