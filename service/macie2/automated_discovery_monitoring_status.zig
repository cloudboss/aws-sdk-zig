/// Specifies whether automated sensitive data discovery is currently configured
/// to analyze objects in an S3 bucket. Possible values are:
pub const AutomatedDiscoveryMonitoringStatus = enum {
    monitored,
    not_monitored,

    pub const json_field_names = .{
        .monitored = "MONITORED",
        .not_monitored = "NOT_MONITORED",
    };
};
