pub const CreateSpaceResponse = struct {
    /// The space's Amazon Resource Name (ARN).
    space_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .space_arn = "SpaceArn",
    };
};
