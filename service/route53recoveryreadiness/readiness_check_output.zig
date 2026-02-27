const aws = @import("aws");

/// A readiness check.
pub const ReadinessCheckOutput = struct {
    /// The Amazon Resource Name (ARN) associated with a readiness check.
    readiness_check_arn: []const u8,

    /// Name of a readiness check.
    readiness_check_name: ?[]const u8,

    /// Name of the resource set to be checked.
    resource_set: []const u8,

    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .readiness_check_arn = "ReadinessCheckArn",
        .readiness_check_name = "ReadinessCheckName",
        .resource_set = "ResourceSet",
        .tags = "Tags",
    };
};
