/// The metadata transfer job AWS IoT TwinMaker destination configuration.
pub const IotTwinMakerDestinationConfiguration = struct {
    /// The IoT TwinMaker workspace.
    workspace: []const u8,

    pub const json_field_names = .{
        .workspace = "workspace",
    };
};
