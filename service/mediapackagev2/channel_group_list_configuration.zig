/// The configuration of the channel group.
pub const ChannelGroupListConfiguration = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The date and time the channel group was created.
    created_at: i64,

    /// Any descriptive information that you want to add to the channel group for
    /// future identification purposes.
    description: ?[]const u8,

    /// The date and time the channel group was modified.
    modified_at: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .created_at = "CreatedAt",
        .description = "Description",
        .modified_at = "ModifiedAt",
    };
};
