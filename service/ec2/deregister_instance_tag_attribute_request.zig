/// Information about the tag keys to deregister for the current Region. You can
/// either
/// specify individual tag keys or deregister all tag keys in the current
/// Region. You must
/// specify either `IncludeAllTagsOfInstance` or `InstanceTagKeys` in the
/// request
pub const DeregisterInstanceTagAttributeRequest = struct {
    /// Indicates whether to deregister all tag keys in the current Region. Specify
    /// `false` to deregister all tag keys.
    include_all_tags_of_instance: ?bool = null,

    /// Information about the tag keys to deregister.
    instance_tag_keys: ?[]const []const u8 = null,
};
