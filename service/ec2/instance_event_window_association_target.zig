const Tag = @import("tag.zig").Tag;

/// One or more targets associated with the event window.
pub const InstanceEventWindowAssociationTarget = struct {
    /// The IDs of the Dedicated Hosts associated with the event window.
    dedicated_host_ids: ?[]const []const u8 = null,

    /// The IDs of the instances associated with the event window.
    instance_ids: ?[]const []const u8 = null,

    /// The instance tags associated with the event window. Any instances associated
    /// with the
    /// tags will be associated with the event window.
    ///
    /// Note that while you can't create tag keys beginning with `aws:`, you can
    /// specify existing Amazon Web Services managed tag keys (with the `aws:`
    /// prefix) when specifying
    /// them as targets to associate with the event window.
    tags: ?[]const Tag = null,
};
