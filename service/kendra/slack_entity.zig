const std = @import("std");

pub const SlackEntity = enum {
    public_channel,
    private_channel,
    group_message,
    direct_message,

    pub const json_field_names = .{
        .public_channel = "PUBLIC_CHANNEL",
        .private_channel = "PRIVATE_CHANNEL",
        .group_message = "GROUP_MESSAGE",
        .direct_message = "DIRECT_MESSAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_channel => "PUBLIC_CHANNEL",
            .private_channel => "PRIVATE_CHANNEL",
            .group_message => "GROUP_MESSAGE",
            .direct_message => "DIRECT_MESSAGE",
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
