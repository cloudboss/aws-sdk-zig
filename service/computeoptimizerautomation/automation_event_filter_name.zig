const std = @import("std");

pub const AutomationEventFilterName = enum {
    account_id,
    resource_type,
    event_type,
    event_status,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .resource_type = "ResourceType",
        .event_type = "EventType",
        .event_status = "EventStatus",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_id => "AccountId",
            .resource_type => "ResourceType",
            .event_type => "EventType",
            .event_status => "EventStatus",
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
