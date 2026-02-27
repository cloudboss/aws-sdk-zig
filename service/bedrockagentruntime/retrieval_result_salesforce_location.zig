/// The Salesforce data source location.
pub const RetrievalResultSalesforceLocation = struct {
    /// The Salesforce host URL for the data source location.
    url: ?[]const u8,

    pub const json_field_names = .{
        .url = "url",
    };
};
