const PagerDutyIncidentDetail = @import("pager_duty_incident_detail.zig").PagerDutyIncidentDetail;

/// Describes a related item.
pub const ItemValue = union(enum) {
    /// The Amazon Resource Name (ARN) of the related item, if the related item is
    /// an Amazon
    /// resource.
    arn: ?[]const u8,
    /// The metric definition, if the related item is a metric in Amazon CloudWatch.
    metric_definition: ?[]const u8,
    /// Details about an incident that is associated with a PagerDuty incident.
    pager_duty_incident_detail: ?PagerDutyIncidentDetail,
    /// The URL, if the related item is a non-Amazon Web Services resource.
    url: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .metric_definition = "metricDefinition",
        .pager_duty_incident_detail = "pagerDutyIncidentDetail",
        .url = "url",
    };
};
