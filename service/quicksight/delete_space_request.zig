pub const DeleteSpaceRequest = struct {
    /// The ID of the Amazon Web Services account that contains the space.
    aws_account_id: []const u8,

    /// The ID of the space that you want to delete.
    space_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .space_id = "SpaceId",
    };
};
