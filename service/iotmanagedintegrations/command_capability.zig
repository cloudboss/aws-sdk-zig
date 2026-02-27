const CapabilityAction = @import("capability_action.zig").CapabilityAction;

/// The command capabilities added for the managed thing
pub const CommandCapability = struct {
    /// Describe the command capability with the actions it supports.
    actions: []const CapabilityAction,

    /// Describe the capability with an id.
    id: []const u8,

    /// Describe the capability with an name.
    name: []const u8,

    /// Describe the capability with a version.
    version: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .id = "id",
        .name = "name",
        .version = "version",
    };
};
