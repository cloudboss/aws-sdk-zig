const std = @import("std");

/// With the introduction of MediaLive Anywhere, a MediaLive input can now exist
/// in two different places: AWS or
/// inside an on-premises datacenter. By default all inputs will continue to be
/// AWS inputs.
pub const InputNetworkLocation = enum {
    aws,
    on_premises,

    pub const json_field_names = .{
        .aws = "AWS",
        .on_premises = "ON_PREMISES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws => "AWS",
            .on_premises => "ON_PREMISES",
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
