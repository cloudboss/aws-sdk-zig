const Tag = @import("tag.zig").Tag;

/// One or more targets associated with the specified event window. Only one
/// *type* of target (instance ID, instance tag, or Dedicated Host ID)
/// can be associated with an event window.
pub const InstanceEventWindowAssociationRequest = struct {
    /// The IDs of the Dedicated Hosts to associate with the event window.
    dedicated_host_ids: ?[]const []const u8,

    /// The IDs of the instances to associate with the event window. If the instance
    /// is on a
    /// Dedicated Host, you can't specify the Instance ID parameter; you must use
    /// the Dedicated
    /// Host ID parameter.
    instance_ids: ?[]const []const u8,

    /// The instance tags to associate with the event window. Any instances
    /// associated with the
    /// tags will be associated with the event window.
    ///
    /// Note that while you can't create tag keys beginning with `aws:`, you can
    /// specify existing Amazon Web Services managed tag keys (with the `aws:`
    /// prefix) when specifying
    /// them as targets to associate with the event window.
    instance_tags: ?[]const Tag,
};
