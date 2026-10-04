const std = @import("std");

pub const ImpersonationRoleType = enum {
    full_access,
    read_only,

    pub const json_field_names = .{
        .full_access = "FULL_ACCESS",
        .read_only = "READ_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .full_access => "FULL_ACCESS",
            .read_only => "READ_ONLY",
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
