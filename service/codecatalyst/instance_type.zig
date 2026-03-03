const std = @import("std");

pub const InstanceType = enum {
    dev_standard1_small,
    dev_standard1_medium,
    dev_standard1_large,
    dev_standard1_xlarge,

    pub const json_field_names = .{
        .dev_standard1_small = "dev.standard1.small",
        .dev_standard1_medium = "dev.standard1.medium",
        .dev_standard1_large = "dev.standard1.large",
        .dev_standard1_xlarge = "dev.standard1.xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dev_standard1_small => "dev.standard1.small",
            .dev_standard1_medium => "dev.standard1.medium",
            .dev_standard1_large => "dev.standard1.large",
            .dev_standard1_xlarge => "dev.standard1.xlarge",
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
