const std = @import("std");

pub const ListNotificationRulesFilterName = enum {
    event_type_id,
    created_by,
    resource,
    target_address,

    pub const json_field_names = .{
        .event_type_id = "EVENT_TYPE_ID",
        .created_by = "CREATED_BY",
        .resource = "RESOURCE",
        .target_address = "TARGET_ADDRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event_type_id => "EVENT_TYPE_ID",
            .created_by => "CREATED_BY",
            .resource => "RESOURCE",
            .target_address => "TARGET_ADDRESS",
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
