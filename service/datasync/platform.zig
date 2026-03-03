/// The platform-related details about the DataSync agent, such as the version
/// number.
pub const Platform = struct {
    /// The version of the DataSync agent.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .version = "Version",
    };
};
