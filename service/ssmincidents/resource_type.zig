const std = @import("std");

pub const ResourceType = enum {
    response_plan,
    incident_record,
    timeline_event,
    replication_set,
    resource_policy,

    pub const json_field_names = .{
        .response_plan = "RESPONSE_PLAN",
        .incident_record = "INCIDENT_RECORD",
        .timeline_event = "TIMELINE_EVENT",
        .replication_set = "REPLICATION_SET",
        .resource_policy = "RESOURCE_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .response_plan => "RESPONSE_PLAN",
            .incident_record => "INCIDENT_RECORD",
            .timeline_event => "TIMELINE_EVENT",
            .replication_set => "REPLICATION_SET",
            .resource_policy => "RESOURCE_POLICY",
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
