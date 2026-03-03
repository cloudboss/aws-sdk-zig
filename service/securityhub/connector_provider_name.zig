const std = @import("std");

pub const ConnectorProviderName = enum {
    jira_cloud,
    servicenow,

    pub const json_field_names = .{
        .jira_cloud = "JIRA_CLOUD",
        .servicenow = "SERVICENOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jira_cloud => "JIRA_CLOUD",
            .servicenow => "SERVICENOW",
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
