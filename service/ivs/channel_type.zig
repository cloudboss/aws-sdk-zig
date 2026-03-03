const std = @import("std");

pub const ChannelType = enum {
    basic_channel_type,
    standard_channel_type,
    advanced_sd_channel_type,
    advanced_hd_channel_type,

    pub const json_field_names = .{
        .basic_channel_type = "BASIC",
        .standard_channel_type = "STANDARD",
        .advanced_sd_channel_type = "ADVANCED_SD",
        .advanced_hd_channel_type = "ADVANCED_HD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .basic_channel_type => "BASIC",
            .standard_channel_type => "STANDARD",
            .advanced_sd_channel_type => "ADVANCED_SD",
            .advanced_hd_channel_type => "ADVANCED_HD",
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
