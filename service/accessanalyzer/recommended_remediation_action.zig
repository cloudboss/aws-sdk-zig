const std = @import("std");

pub const RecommendedRemediationAction = enum {
    create_policy,
    detach_policy,

    pub const json_field_names = .{
        .create_policy = "CREATE_POLICY",
        .detach_policy = "DETACH_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_policy => "CREATE_POLICY",
            .detach_policy => "DETACH_POLICY",
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
