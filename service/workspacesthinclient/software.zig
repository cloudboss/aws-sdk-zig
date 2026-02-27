/// Describes software.
pub const Software = struct {
    /// The name of the software component.
    name: ?[]const u8,

    /// The version of the software component.
    version: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};
