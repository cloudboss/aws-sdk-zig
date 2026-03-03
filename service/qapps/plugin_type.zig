const std = @import("std");

pub const PluginType = enum {
    service_now,
    salesforce,
    jira,
    zendesk,
    custom,
    asana,
    atlassian_confluence,
    google_calendar,
    jira_cloud,
    microsoft_exchange,
    microsoft_teams,
    pagerduty_advance,
    salesforce_crm,
    servicenow_now_platform,
    smartsheet,
    zendesk_suite,

    pub const json_field_names = .{
        .service_now = "SERVICE_NOW",
        .salesforce = "SALESFORCE",
        .jira = "JIRA",
        .zendesk = "ZENDESK",
        .custom = "CUSTOM",
        .asana = "ASANA",
        .atlassian_confluence = "ATLASSIAN_CONFLUENCE",
        .google_calendar = "GOOGLE_CALENDAR",
        .jira_cloud = "JIRA_CLOUD",
        .microsoft_exchange = "MICROSOFT_EXCHANGE",
        .microsoft_teams = "MICROSOFT_TEAMS",
        .pagerduty_advance = "PAGERDUTY_ADVANCE",
        .salesforce_crm = "SALESFORCE_CRM",
        .servicenow_now_platform = "SERVICENOW_NOW_PLATFORM",
        .smartsheet = "SMARTSHEET",
        .zendesk_suite = "ZENDESK_SUITE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_now => "SERVICE_NOW",
            .salesforce => "SALESFORCE",
            .jira => "JIRA",
            .zendesk => "ZENDESK",
            .custom => "CUSTOM",
            .asana => "ASANA",
            .atlassian_confluence => "ATLASSIAN_CONFLUENCE",
            .google_calendar => "GOOGLE_CALENDAR",
            .jira_cloud => "JIRA_CLOUD",
            .microsoft_exchange => "MICROSOFT_EXCHANGE",
            .microsoft_teams => "MICROSOFT_TEAMS",
            .pagerduty_advance => "PAGERDUTY_ADVANCE",
            .salesforce_crm => "SALESFORCE_CRM",
            .servicenow_now_platform => "SERVICENOW_NOW_PLATFORM",
            .smartsheet => "SMARTSHEET",
            .zendesk_suite => "ZENDESK_SUITE",
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
