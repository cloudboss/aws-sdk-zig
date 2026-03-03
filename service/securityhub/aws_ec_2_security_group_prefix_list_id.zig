/// A prefix list ID.
pub const AwsEc2SecurityGroupPrefixListId = struct {
    /// The ID of the prefix.
    prefix_list_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .prefix_list_id = "PrefixListId",
    };
};
