/// Id of the engine version.
pub const EngineVersion = struct {
    /// Id for the version.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
