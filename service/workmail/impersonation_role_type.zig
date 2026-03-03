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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
