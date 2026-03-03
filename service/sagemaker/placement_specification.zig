/// Specifies how instances should be placed on a specific UltraServer.
pub const PlacementSpecification = struct {
    /// The number of ML compute instances required to be placed together on the
    /// same UltraServer. Minimum value of 1.
    instance_count: i32,

    /// The unique identifier of the UltraServer where instances should be placed.
    ultra_server_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .ultra_server_id = "UltraServerId",
    };
};
