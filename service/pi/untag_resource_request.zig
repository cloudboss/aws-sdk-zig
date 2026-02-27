const ServiceType = @import("service_type.zig").ServiceType;

pub const UntagResourceRequest = struct {
    /// The Amazon RDS Performance Insights resource that the tags are added to.
    /// This value is an Amazon Resource Name (ARN). For information about
    /// creating an ARN, see [
    /// Constructing an RDS Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.ARN.html#USER_Tagging.ARN.Constructing).
    resource_arn: []const u8,

    /// List the tags for the Amazon Web Services service for which Performance
    /// Insights returns metrics. Valid value is `RDS`.
    service_type: ServiceType,

    /// The metadata assigned to an Amazon RDS Performance Insights resource
    /// consisting of a key-value pair.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .service_type = "ServiceType",
        .tag_keys = "TagKeys",
    };
};
