const Metadata = @import("metadata.zig").Metadata;

/// Contains the JSON-formatted string returned by the API invoked by the action
/// group.
pub const ActionGroupInvocationOutput = struct {
    /// Contains information about the action group output.
    metadata: ?Metadata = null,

    /// The JSON-formatted string returned by the API invoked by the action group.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "metadata",
        .text = "text",
    };
};
