/// Describes the registered tag keys for the current Region.
pub const InstanceTagNotificationAttribute = struct {
    /// Indicates wheter all tag keys in the current Region are registered to appear
    /// in
    /// scheduled event notifications. `true` indicates that all tag keys in the
    /// current
    /// Region are registered.
    include_all_tags_of_instance: ?bool,

    /// The registered tag keys.
    instance_tag_keys: ?[]const []const u8,
};
