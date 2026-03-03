const std = @import("std");

pub const GenerationSortByAttribute = enum {
    creation_start_time,
    last_updated_time,

    pub const json_field_names = .{
        .creation_start_time = "creationStartTime",
        .last_updated_time = "lastUpdatedTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creation_start_time => "creationStartTime",
            .last_updated_time => "lastUpdatedTime",
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
