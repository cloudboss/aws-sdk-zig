/// A tag on an IPAM resource.
pub const RequestIpamResourceTag = struct {
    /// The key of a tag assigned to the resource. Use this filter to find all
    /// resources assigned a tag with a specific key, regardless of the tag value.
    key: ?[]const u8 = null,

    /// The value for the tag.
    value: ?[]const u8 = null,
};
