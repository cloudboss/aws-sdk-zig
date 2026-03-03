const std = @import("std");

pub const ExecutionMode = enum {
    on_demand,
    scheduled,

    pub const json_field_names = .{
        .on_demand = "ON_DEMAND",
        .scheduled = "SCHEDULED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .on_demand => "ON_DEMAND",
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
