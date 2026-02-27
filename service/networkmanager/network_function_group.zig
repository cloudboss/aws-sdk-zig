/// Describes a network function group for service insertion.
pub const NetworkFunctionGroup = struct {
    /// The name of the network function group.
    name: ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
