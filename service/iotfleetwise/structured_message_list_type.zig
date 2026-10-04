const std = @import("std");

pub const StructuredMessageListType = enum {
    fixed_capacity,
    dynamic_unbounded_capacity,
    dynamic_bounded_capacity,

    pub const json_field_names = .{
        .fixed_capacity = "FIXED_CAPACITY",
        .dynamic_unbounded_capacity = "DYNAMIC_UNBOUNDED_CAPACITY",
        .dynamic_bounded_capacity = "DYNAMIC_BOUNDED_CAPACITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fixed_capacity => "FIXED_CAPACITY",
            .dynamic_unbounded_capacity => "DYNAMIC_UNBOUNDED_CAPACITY",
            .dynamic_bounded_capacity => "DYNAMIC_BOUNDED_CAPACITY",
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
