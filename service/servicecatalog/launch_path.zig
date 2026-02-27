/// A launch path object.
pub const LaunchPath = struct {
    /// The identifier of the launch path.
    id: ?[]const u8,

    /// The name of the launch path.
    name: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
    };
};
