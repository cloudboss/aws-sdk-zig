const std = @import("std");

pub const ResiliencyModel = enum {
    maximum_resiliency,
    high_resiliency,
    basic_resiliency,

    pub const json_field_names = .{
        .maximum_resiliency = "maximum-resiliency",
        .high_resiliency = "high-resiliency",
        .basic_resiliency = "basic-resiliency",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .maximum_resiliency => "maximum-resiliency",
            .high_resiliency => "high-resiliency",
            .basic_resiliency => "basic-resiliency",
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
