const std = @import("std");

pub const TransactionType = enum {
    read_and_write,
    read_only,

    pub const json_field_names = .{
        .read_and_write = "READ_AND_WRITE",
        .read_only = "READ_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .read_and_write => "READ_AND_WRITE",
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
