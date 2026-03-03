const std = @import("std");

pub const DataSourceType = enum {
    s3,
    sharepoint,
    database,
    salesforce,
    onedrive,
    servicenow,
    custom,
    confluence,
    googledrive,
    webcrawler,
    workdocs,
    fsx,
    slack,
    box,
    quip,
    jira,
    github,
    alfresco,
    template,

    pub const json_field_names = .{
        .s3 = "S3",
        .sharepoint = "SHAREPOINT",
        .database = "DATABASE",
        .salesforce = "SALESFORCE",
        .onedrive = "ONEDRIVE",
        .servicenow = "SERVICENOW",
        .custom = "CUSTOM",
        .confluence = "CONFLUENCE",
        .googledrive = "GOOGLEDRIVE",
        .webcrawler = "WEBCRAWLER",
        .workdocs = "WORKDOCS",
        .fsx = "FSX",
        .slack = "SLACK",
        .box = "BOX",
        .quip = "QUIP",
        .jira = "JIRA",
        .github = "GITHUB",
        .alfresco = "ALFRESCO",
        .template = "TEMPLATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .s3 => "S3",
            .sharepoint => "SHAREPOINT",
            .database => "DATABASE",
            .salesforce => "SALESFORCE",
            .onedrive => "ONEDRIVE",
            .servicenow => "SERVICENOW",
            .custom => "CUSTOM",
            .confluence => "CONFLUENCE",
            .googledrive => "GOOGLEDRIVE",
            .webcrawler => "WEBCRAWLER",
            .workdocs => "WORKDOCS",
            .fsx => "FSX",
            .slack => "SLACK",
            .box => "BOX",
            .quip => "QUIP",
            .jira => "JIRA",
            .github => "GITHUB",
            .alfresco => "ALFRESCO",
            .template => "TEMPLATE",
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
