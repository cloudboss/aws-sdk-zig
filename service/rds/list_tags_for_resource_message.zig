const Filter = @import("filter.zig").Filter;

pub const ListTagsForResourceMessage = struct {
    /// This parameter isn't currently supported.
    filters: ?[]const Filter,

    /// The Amazon RDS resource with tags to be listed. This value is an Amazon
    /// Resource Name (ARN). For information about creating an ARN, see [
    /// Constructing an ARN for Amazon
    /// RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing) in the *Amazon RDS User Guide*.
    resource_name: []const u8,
};
