/// Information about the tag keys to register for the current Region. You can
/// either
/// specify individual tag keys or register all tag keys in the current Region.
/// You must
/// specify either `IncludeAllTagsOfInstance` or `InstanceTagKeys` in the
/// request
pub const RegisterInstanceTagAttributeRequest = struct {
    /// Indicates whether to register all tag keys in the current Region. Specify
    /// `true` to register all tag keys.
    include_all_tags_of_instance: ?bool = null,

    /// The tag keys to register.
    instance_tag_keys: ?[]const []const u8 = null,
};
