pub const UpdateSpaceRequest = struct {
    /// The ID of the Amazon Web Services account that contains the space.
    aws_account_id: []const u8,

    /// A new description for the space.
    description: ?[]const u8 = null,

    /// A new display name for the space.
    name: ?[]const u8 = null,

    /// The ID of the space that you want to update.
    space_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .description = "Description",
        .name = "Name",
        .space_id = "SpaceId",
    };
};
