const std = @import("std");

pub const ContainerServicePowerName = enum {
    nano,
    micro,
    small,
    medium,
    large,
    xlarge,

    pub const json_field_names = .{
        .nano = "nano",
        .micro = "micro",
        .small = "small",
        .medium = "medium",
        .large = "large",
        .xlarge = "xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nano => "nano",
            .micro => "micro",
            .small => "small",
            .medium => "medium",
            .large => "large",
            .xlarge => "xlarge",
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
