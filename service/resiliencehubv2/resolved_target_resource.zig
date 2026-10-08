const aws = @import("aws");

/// A single AWS resource that AWS Fault Injection Service (AWS FIS) resolved as
/// a target during a test run.
pub const ResolvedTargetResource = struct {
    /// The AWS FIS resource type the target belongs to, such as aws:ec2:instance,
    /// aws:ecs:task, or aws:eks:pod.
    resource_type: []const u8,

    /// The raw target information map as returned by AWS FIS.
    target_information: []const aws.map.StringMapEntry,

    /// The name of the target in the AWS FIS experiment template.
    target_name: []const u8,

    pub const json_field_names = .{
        .resource_type = "resourceType",
        .target_information = "targetInformation",
        .target_name = "targetName",
    };
};
