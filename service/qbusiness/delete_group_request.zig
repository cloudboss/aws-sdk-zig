pub const DeleteGroupRequest = struct {
    /// The identifier of the application in which the group mapping belongs.
    application_id: []const u8,

    /// The identifier of the data source linked to the group
    ///
    /// A group can be tied to multiple data sources. You can delete a group from
    /// accessing documents in a certain data source. For example, the groups
    /// "Research", "Engineering", and "Sales and Marketing" are all tied to the
    /// company's documents stored in the data sources Confluence and Salesforce.
    /// You want to delete "Research" and "Engineering" groups from Salesforce, so
    /// that these groups cannot access customer-related documents stored in
    /// Salesforce. Only "Sales and Marketing" should access documents in the
    /// Salesforce data source.
    data_source_id: ?[]const u8 = null,

    /// The name of the group you want to delete.
    group_name: []const u8,

    /// The identifier of the index you want to delete the group from.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .group_name = "groupName",
        .index_id = "indexId",
    };
};
