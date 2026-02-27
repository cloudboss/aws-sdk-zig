const ServiceType = @import("service_type.zig").ServiceType;
const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
    /// The Amazon RDS Performance Insights resource that the tags are added to.
    /// This value is an Amazon Resource Name (ARN). For information about
    /// creating an ARN, see [
    /// Constructing an RDS Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing).
    resource_arn: []const u8,

    /// The Amazon Web Services service for which Performance Insights returns
    /// metrics. Valid value is `RDS`.
    service_type: ServiceType,

    /// The metadata assigned to an Amazon RDS resource consisting of a key-value
    /// pair.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .service_type = "ServiceType",
        .tags = "Tags",
    };
};
