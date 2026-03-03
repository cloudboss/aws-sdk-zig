const std = @import("std");

pub const RetryStrategy = enum {
    retry_with_group_configuration,
    none,

    pub const json_field_names = .{
        .retry_with_group_configuration = "retry-with-group-configuration",
        .none = "none",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .retry_with_group_configuration => "retry-with-group-configuration",
            .none => "none",
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
