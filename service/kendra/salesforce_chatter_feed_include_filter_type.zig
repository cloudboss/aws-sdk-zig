const std = @import("std");

pub const SalesforceChatterFeedIncludeFilterType = enum {
    active_user,
    standard_user,

    pub const json_field_names = .{
        .active_user = "ACTIVE_USER",
        .standard_user = "STANDARD_USER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active_user => "ACTIVE_USER",
            .standard_user => "STANDARD_USER",
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
