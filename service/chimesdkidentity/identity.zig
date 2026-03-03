/// The details of a user or bot.
pub const Identity = struct {
    /// The ARN in an Identity.
    arn: ?[]const u8 = null,

    /// The name in an Identity.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
