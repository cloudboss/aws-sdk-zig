pub const UntagResourceRequest = struct {
    /// The ID of the resource to remove a tag from.
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

    /// The list of keys for tags to remove from the specified resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tag_keys = "TagKeys",
    };
};
