const std = @import("std");

pub const NodeUnavailabilityType = enum {
    instance_count,
    capacity_percentage,

    pub const json_field_names = .{
        .instance_count = "INSTANCE_COUNT",
        .capacity_percentage = "CAPACITY_PERCENTAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .instance_count => "INSTANCE_COUNT",
            .capacity_percentage => "CAPACITY_PERCENTAGE",
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
