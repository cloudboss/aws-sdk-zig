const std = @import("std");

/// The values for the role for a linked channel.
pub const LinkedChannelType = enum {
    following_channel,
    primary_channel,

    pub const json_field_names = .{
        .following_channel = "FOLLOWING_CHANNEL",
        .primary_channel = "PRIMARY_CHANNEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .following_channel => "FOLLOWING_CHANNEL",
            .primary_channel => "PRIMARY_CHANNEL",
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
