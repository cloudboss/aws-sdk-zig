pub const CreateSpaceRequest = struct {
    /// The ID of the Amazon Web Services account that contains the space.
    aws_account_id: []const u8,

    /// A description of the space.
    description: ?[]const u8 = null,

    /// A display name for the space.
    name: []const u8,

    /// The ID of the space. This ID is unique per Amazon Web Services Region for
    /// each Amazon Web Services account.
    space_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .description = "Description",
        .name = "Name",
        .space_id = "SpaceId",
    };
};
