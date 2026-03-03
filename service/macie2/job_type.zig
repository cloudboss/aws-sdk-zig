const std = @import("std");

/// The schedule for running a classification job. Valid values are:
pub const JobType = enum {
    one_time,
    scheduled,

    pub const json_field_names = .{
        .one_time = "ONE_TIME",
        .scheduled = "SCHEDULED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_time => "ONE_TIME",
            .scheduled => "SCHEDULED",
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
