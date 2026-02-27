pub const ListTagsForResourceRequest = struct {
    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken` response
    /// indicates that more output is available. Set this parameter to the value of
    /// the previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8,

    /// The ID of the resource with the tags to list.
    ///
    /// You can specify any of the following taggable resources.
    ///
    /// * Amazon Web Services account – specify the account ID number.
    ///
    /// * Organizational unit – specify the OU ID that begins with `ou-` and
    /// looks similar to: `ou-*1a2b-34uvwxyz*
    /// `
    ///
    /// * Root – specify the root ID that begins with `r-` and looks similar
    /// to: `r-*1a2b*
    /// `
    ///
    /// * Policy – specify the policy ID that begins with `p-` andlooks
    /// similar to: `p-*12abcdefg3*
    /// `
    resource_id: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_id = "ResourceId",
    };
};
