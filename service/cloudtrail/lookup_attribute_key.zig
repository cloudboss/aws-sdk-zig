const std = @import("std");

pub const LookupAttributeKey = enum {
    event_id,
    event_name,
    read_only,
    username,
    resource_type,
    resource_name,
    event_source,
    access_key_id,

    pub const json_field_names = .{
        .event_id = "EventId",
        .event_name = "EventName",
        .read_only = "ReadOnly",
        .username = "Username",
        .resource_type = "ResourceType",
        .resource_name = "ResourceName",
        .event_source = "EventSource",
        .access_key_id = "AccessKeyId",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_id => "EventId",
            .event_name => "EventName",
            .read_only => "ReadOnly",
            .username => "Username",
            .resource_type => "ResourceType",
            .resource_name => "ResourceName",
            .event_source => "EventSource",
            .access_key_id => "AccessKeyId",
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
