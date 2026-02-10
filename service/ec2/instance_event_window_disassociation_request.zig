const Tag = @import("tag.zig").Tag;

/// The targets to disassociate from the specified event window.
pub const InstanceEventWindowDisassociationRequest = struct {
    /// The IDs of the Dedicated Hosts to disassociate from the event window.
    dedicated_host_ids: ?[]const []const u8,

    /// The IDs of the instances to disassociate from the event window.
    instance_ids: ?[]const []const u8,

    /// The instance tags to disassociate from the event window. Any instances
    /// associated with
    /// the tags will be disassociated from the event window.
    instance_tags: ?[]const Tag,
};
