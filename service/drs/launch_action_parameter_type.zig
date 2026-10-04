const std = @import("std");

pub const LaunchActionParameterType = enum {
    ssm_store,
    dynamic,

    pub const json_field_names = .{
        .ssm_store = "SSM_STORE",
        .dynamic = "DYNAMIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ssm_store => "SSM_STORE",
            .dynamic => "DYNAMIC",
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
