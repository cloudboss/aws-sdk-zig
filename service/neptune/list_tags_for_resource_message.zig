const Filter = @import("filter.zig").Filter;

pub const ListTagsForResourceMessage = struct {
    /// This parameter is not currently supported.
    filters: ?[]const Filter,

    /// The Amazon Neptune resource with tags to be listed. This value is an Amazon
    /// Resource Name
    /// (ARN). For information about creating an ARN, see [ Constructing an
    /// Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/neptune/latest/UserGuide/tagging.ARN.html#tagging.ARN.Constructing).
    resource_name: []const u8,
};
