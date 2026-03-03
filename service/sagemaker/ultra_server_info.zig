/// Contains information about the UltraServer object.
pub const UltraServerInfo = struct {
    /// The unique identifier of the UltraServer.
    id: ?[]const u8 = null,

    /// The type of the UltraServer.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .@"type" = "Type",
    };
};
