const std = @import("std");

pub const TargetDeployment = enum {
    single_account,
    multi_account,

    pub const json_field_names = .{
        .single_account = "SINGLE_ACCOUNT",
        .multi_account = "MULTI_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_account => "SINGLE_ACCOUNT",
            .multi_account => "MULTI_ACCOUNT",
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
