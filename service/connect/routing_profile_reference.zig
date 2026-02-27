/// Information about the routing profile assigned to the user.
pub const RoutingProfileReference = struct {
    /// The Amazon Resource Name (ARN) of the routing profile.
    arn: ?[]const u8,

    /// The identifier of the routing profile.
    id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};
