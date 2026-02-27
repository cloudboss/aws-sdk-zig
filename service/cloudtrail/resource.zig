/// Specifies the type and name of a resource referenced by an event.
pub const Resource = struct {
    /// The name of the resource referenced by the event returned. These are
    /// user-created names
    /// whose values will depend on the environment. For example, the resource name
    /// might be
    /// "auto-scaling-test-group" for an Auto Scaling Group or "i-1234567" for an
    /// EC2
    /// Instance.
    resource_name: ?[]const u8,

    /// The type of a resource referenced by the event returned. When the resource
    /// type cannot
    /// be determined, null is returned. Some examples of resource types are:
    /// **Instance** for EC2, **Trail** for CloudTrail, **DBInstance** for Amazon
    /// RDS, and **AccessKey** for IAM. To learn more about how to look up and
    /// filter
    /// events by the resource types supported for a service, see [Filtering
    /// CloudTrail
    /// Events](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/view-cloudtrail-events-console.html#filtering-cloudtrail-events).
    resource_type: ?[]const u8,

    pub const json_field_names = .{
        .resource_name = "ResourceName",
        .resource_type = "ResourceType",
    };
};
