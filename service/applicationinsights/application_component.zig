const aws = @import("aws");

const OsType = @import("os_type.zig").OsType;
const Tier = @import("tier.zig").Tier;

/// Describes a standalone resource or similarly grouped resources that the
/// application is
/// made up of.
pub const ApplicationComponent = struct {
    /// The name of the component.
    component_name: ?[]const u8,

    /// If logging is supported for the resource type, indicates whether the
    /// component has
    /// configured logs to be monitored.
    component_remarks: ?[]const u8,

    /// Workloads detected in the application component.
    detected_workload: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry),

    /// Indicates whether the application component is monitored.
    monitor: ?bool,

    /// The operating system of the component.
    os_type: ?OsType,

    /// The resource type. Supported resource types include EC2 instances, Auto
    /// Scaling group,
    /// Classic ELB, Application ELB, and SQS Queue.
    resource_type: ?[]const u8,

    /// The stack tier of the application component.
    tier: ?Tier,

    pub const json_field_names = .{
        .component_name = "ComponentName",
        .component_remarks = "ComponentRemarks",
        .detected_workload = "DetectedWorkload",
        .monitor = "Monitor",
        .os_type = "OsType",
        .resource_type = "ResourceType",
        .tier = "Tier",
    };
};
