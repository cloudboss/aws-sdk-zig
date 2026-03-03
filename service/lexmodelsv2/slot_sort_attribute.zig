const std = @import("std");

pub const SlotSortAttribute = enum {
    slot_name,
    last_updated_date_time,

    pub const json_field_names = .{
        .slot_name = "SlotName",
        .last_updated_date_time = "LastUpdatedDateTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .slot_name => "SlotName",
            .last_updated_date_time => "LastUpdatedDateTime",
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
