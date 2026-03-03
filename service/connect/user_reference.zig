/// Information about the user.
pub const UserReference = struct {
    /// The Amazon Resource Name (ARN) for the user.
    arn: ?[]const u8 = null,

    /// The unique identifier for the user.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
