const Tag = @import("tag.zig").Tag;

pub const PutResourcePolicyRequest = struct {
    /// If provided, the new content for the resource policy. The text must be
    /// correctly
    /// formatted JSON that complies with the syntax for the resource policy's type.
    /// For more
    /// information, see [SCP
    /// syntax](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_scps_syntax.html) in the
    /// *Organizations User Guide*.
    content: []const u8,

    /// A list of tags that you want to attach to the newly created resource policy.
    /// For each
    /// tag in the list, you must specify both a tag key and a value. You can set
    /// the value to
    /// an empty string, but you can't set it to `null`. For more information about
    /// tagging, see [Tagging
    /// Organizations
    /// resources](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_tagging.html) in the Organizations User Guide.
    ///
    /// Calls with tags apply to the initial creation of the resource policy,
    /// otherwise an
    /// exception is thrown. If any one of the tags is not valid or if you exceed
    /// the
    /// allowed number of tags for the resource policy, then the entire request
    /// fails and
    /// the resource policy is not created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .content = "Content",
        .tags = "Tags",
    };
};
