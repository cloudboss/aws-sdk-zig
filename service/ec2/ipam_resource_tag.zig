/// The key/value combination of a tag assigned to the resource. Use the tag key
/// in the filter name and the tag value as the filter value.
/// For example, to find all resources that have a tag with the key `Owner` and
/// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
/// the filter value.
pub const IpamResourceTag = struct {
    /// The key of a tag assigned to the resource. Use this filter to find all
    /// resources assigned a tag with a specific key, regardless of the tag value.
    key: ?[]const u8 = null,

    /// The value of the tag.
    value: ?[]const u8 = null,
};
