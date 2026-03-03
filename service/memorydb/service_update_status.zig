const std = @import("std");

pub const ServiceUpdateStatus = enum {
    not_applied,
    in_progress,
    complete,
    scheduled,

    pub const json_field_names = .{
        .not_applied = "available",
        .in_progress = "in-progress",
        .complete = "complete",
        .scheduled = "scheduled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_applied => "available",
            .in_progress => "in-progress",
            .complete => "complete",
            .scheduled => "scheduled",
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
