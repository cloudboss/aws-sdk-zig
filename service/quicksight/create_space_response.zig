pub const CreateSpaceResponse = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The ARN of the space.
    space_arn: ?[]const u8 = null,

    /// The ID of the space.
    space_id: []const u8,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .space_arn = "spaceArn",
        .space_id = "spaceId",
    };
};
