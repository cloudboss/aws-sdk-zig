/// Information about the user.
pub const UserReference = struct {
    /// The Amazon Resource Name (ARN) for the user.
    arn: ?[]const u8,

    /// The unique identifier for the user.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
