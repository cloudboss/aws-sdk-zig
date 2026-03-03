const std = @import("std");

pub const ConnectorType = enum {
    salesforce,
    singular,
    slack,
    redshift,
    s3,
    marketo,
    googleanalytics,
    zendesk,
    servicenow,
    datadog,
    trendmicro,
    snowflake,
    dynatrace,
    infornexus,
    amplitude,
    veeva,
    eventbridge,
    lookoutmetrics,
    upsolver,
    honeycode,
    customerprofiles,
    sapodata,
    customconnector,
    pardot,

    pub const json_field_names = .{
        .salesforce = "Salesforce",
        .singular = "Singular",
        .slack = "Slack",
        .redshift = "Redshift",
        .s3 = "S3",
        .marketo = "Marketo",
        .googleanalytics = "Googleanalytics",
        .zendesk = "Zendesk",
        .servicenow = "Servicenow",
        .datadog = "Datadog",
        .trendmicro = "Trendmicro",
        .snowflake = "Snowflake",
        .dynatrace = "Dynatrace",
        .infornexus = "Infornexus",
        .amplitude = "Amplitude",
        .veeva = "Veeva",
        .eventbridge = "EventBridge",
        .lookoutmetrics = "LookoutMetrics",
        .upsolver = "Upsolver",
        .honeycode = "Honeycode",
        .customerprofiles = "CustomerProfiles",
        .sapodata = "SAPOData",
        .customconnector = "CustomConnector",
        .pardot = "Pardot",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .salesforce => "Salesforce",
            .singular => "Singular",
            .slack => "Slack",
            .redshift => "Redshift",
            .s3 => "S3",
            .marketo => "Marketo",
            .googleanalytics => "Googleanalytics",
            .zendesk => "Zendesk",
            .servicenow => "Servicenow",
            .datadog => "Datadog",
            .trendmicro => "Trendmicro",
            .snowflake => "Snowflake",
            .dynatrace => "Dynatrace",
            .infornexus => "Infornexus",
            .amplitude => "Amplitude",
            .veeva => "Veeva",
            .eventbridge => "EventBridge",
            .lookoutmetrics => "LookoutMetrics",
            .upsolver => "Upsolver",
            .honeycode => "Honeycode",
            .customerprofiles => "CustomerProfiles",
            .sapodata => "SAPOData",
            .customconnector => "CustomConnector",
            .pardot => "Pardot",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
