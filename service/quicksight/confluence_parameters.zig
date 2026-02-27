/// The parameters that are required to connect to a Confluence data source
pub const ConfluenceParameters = struct {
    /// The URL of the Confluence site to connect to.
    confluence_url: []const u8,

    pub const json_field_names = .{
        .confluence_url = "ConfluenceUrl",
    };
};
