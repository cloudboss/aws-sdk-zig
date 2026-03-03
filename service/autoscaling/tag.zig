/// Describes a tag for an Auto Scaling group.
pub const Tag = struct {
    /// The tag key.
    key: []const u8,

    /// Determines whether the tag is added to new instances as they are launched in
    /// the
    /// group.
    propagate_at_launch: ?bool = null,

    /// The name of the Auto Scaling group.
    resource_id: ?[]const u8 = null,

    /// The type of resource. The only supported value is
    /// `auto-scaling-group`.
    resource_type: ?[]const u8 = null,

    /// The tag value.
    value: ?[]const u8 = null,
};
