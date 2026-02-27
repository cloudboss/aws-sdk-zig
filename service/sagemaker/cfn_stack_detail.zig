/// Details about the CloudFormation stack.
pub const CfnStackDetail = struct {
    /// The unique identifier of the CloudFormation stack.
    id: ?[]const u8,

    /// The name of the CloudFormation stack.
    name: ?[]const u8,

    /// A human-readable message about the stack's current status.
    status_message: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .status_message = "StatusMessage",
    };
};
