const ConfigurationEventResourceType = @import("configuration_event_resource_type.zig").ConfigurationEventResourceType;
const ConfigurationEventStatus = @import("configuration_event_status.zig").ConfigurationEventStatus;

/// The event information.
pub const ConfigurationEvent = struct {
    /// The Amazon Web Services account ID for the owner of the application to which
    /// the configuration event belongs.
    account_id: ?[]const u8,

    /// The details of the event in plain text.
    event_detail: ?[]const u8,

    /// The name of the resource Application Insights attempted to configure.
    event_resource_name: ?[]const u8,

    /// The resource type that Application Insights attempted to configure, for
    /// example,
    /// CLOUDWATCH_ALARM.
    event_resource_type: ?ConfigurationEventResourceType,

    /// The status of the configuration update event. Possible values include INFO,
    /// WARN, and
    /// ERROR.
    event_status: ?ConfigurationEventStatus,

    /// The timestamp of the event.
    event_time: ?i64,

    /// The resource monitored by Application Insights.
    monitored_resource_arn: ?[]const u8,

    /// The name of the resource group of the application to which the configuration
    /// event belongs.
    resource_group_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .event_detail = "EventDetail",
        .event_resource_name = "EventResourceName",
        .event_resource_type = "EventResourceType",
        .event_status = "EventStatus",
        .event_time = "EventTime",
        .monitored_resource_arn = "MonitoredResourceARN",
        .resource_group_name = "ResourceGroupName",
    };
};
