/// Describes software.
pub const Software = struct {
    /// The name of the software component.
    name: ?[]const u8 = null,

    /// The version of the software component.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};
