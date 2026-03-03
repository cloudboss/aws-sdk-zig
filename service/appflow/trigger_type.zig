const std = @import("std");

pub const TriggerType = enum {
    scheduled,
    event,
    ondemand,

    pub const json_field_names = .{
        .scheduled = "Scheduled",
        .event = "Event",
        .ondemand = "OnDemand",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "Scheduled",
            .event => "Event",
            .ondemand => "OnDemand",
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
