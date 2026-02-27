/// A FUOTA task.
pub const FuotaTask = struct {
    arn: ?[]const u8,

    id: ?[]const u8,

    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .name = "Name",
    };
};
