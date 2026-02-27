/// The details
/// related
/// to the
/// resource.
pub const ResourceDetails = struct {
    /// The value of the tag.
    tag_value: ?[]const u8,

    pub const json_field_names = .{
        .tag_value = "tagValue",
    };
};
