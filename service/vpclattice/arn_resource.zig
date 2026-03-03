/// The Amazon Resource Name (ARN) of the resource.
pub const ArnResource = struct {
    /// The Amazon Resource Name (ARN) of the resource.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
    };
};
