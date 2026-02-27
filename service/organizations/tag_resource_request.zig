const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The ID of the resource to add a tag to.
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

    /// A list of tags to add to the specified resource.
    ///
    /// For each tag in the list, you must specify both a tag key and a value. The
    /// value can
    /// be an empty string, but you can't set it to `null`.
    ///
    /// If any one of the tags is not valid or if you exceed the maximum allowed
    /// number of
    /// tags for a resource, then the entire request fails.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_id = "ResourceId",
        .tags = "Tags",
    };
};
