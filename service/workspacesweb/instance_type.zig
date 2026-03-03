const std = @import("std");

pub const InstanceType = enum {
    standard_regular,
    standard_large,
    standard_xlarge,

    pub const json_field_names = .{
        .standard_regular = "standard.regular",
        .standard_large = "standard.large",
        .standard_xlarge = "standard.xlarge",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard_regular => "standard.regular",
            .standard_large => "standard.large",
            .standard_xlarge => "standard.xlarge",
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
