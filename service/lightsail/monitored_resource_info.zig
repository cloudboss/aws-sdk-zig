const ResourceType = @import("resource_type.zig").ResourceType;

/// Describes resource being monitored by an alarm.
///
/// An alarm is a way to monitor your Amazon Lightsail resource metrics. For
/// more information,
/// see [Alarms
/// in Amazon
/// Lightsail](https://docs.aws.amazon.com/lightsail/latest/userguide/amazon-lightsail-alarms).
pub const MonitoredResourceInfo = struct {
    /// The Amazon Resource Name (ARN) of the resource being monitored.
    arn: ?[]const u8,

    /// The name of the Lightsail resource being monitored.
    name: ?[]const u8,

    /// The Lightsail resource type of the resource being monitored.
    ///
    /// Instances, load balancers, and relational databases are the only Lightsail
    /// resources
    /// that can currently be monitored by alarms.
    resource_type: ?ResourceType,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .resource_type = "resourceType",
    };
};
