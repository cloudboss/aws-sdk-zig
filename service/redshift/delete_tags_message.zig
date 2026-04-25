/// Contains the output from the `DeleteTags` action.
pub const DeleteTagsMessage = struct {
    /// The Amazon Resource Name (ARN) from which you want to remove the tag or
    /// tags. For
    /// example, `arn:aws:redshift:us-east-2:123456789:cluster:t1`.
    resource_name: []const u8,

    /// The tag key that you want to delete.
    tag_keys: []const []const u8,
};
