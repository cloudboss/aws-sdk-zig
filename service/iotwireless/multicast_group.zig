/// A multicast group.
pub const MulticastGroup = struct {
    arn: ?[]const u8 = null,

    id: ?[]const u8 = null,

    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
