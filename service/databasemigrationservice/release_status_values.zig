const std = @import("std");

pub const ReleaseStatusValues = enum {
    beta,
    prod,

    pub const json_field_names = .{
        .beta = "beta",
        .prod = "prod",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .beta => "beta",
            .prod => "prod",
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
