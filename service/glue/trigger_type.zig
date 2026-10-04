const std = @import("std");

pub const TriggerType = enum {
    scheduled,
    conditional,
    on_demand,
    event,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .conditional = "CONDITIONAL",
        .on_demand = "ON_DEMAND",
        .event = "EVENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled => "SCHEDULED",
            .conditional => "CONDITIONAL",
            .on_demand => "ON_DEMAND",
            .event => "EVENT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
