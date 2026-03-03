const std = @import("std");

pub const DedicatedTenancyAccountType = enum {
    source_account,
    target_account,

    pub const json_field_names = .{
        .source_account = "SOURCE_ACCOUNT",
        .target_account = "TARGET_ACCOUNT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_account => "SOURCE_ACCOUNT",
            .target_account => "TARGET_ACCOUNT",
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
