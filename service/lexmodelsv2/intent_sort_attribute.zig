const std = @import("std");

pub const IntentSortAttribute = enum {
    intent_name,
    last_updated_date_time,

    pub const json_field_names = .{
        .intent_name = "IntentName",
        .last_updated_date_time = "LastUpdatedDateTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .intent_name => "IntentName",
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
