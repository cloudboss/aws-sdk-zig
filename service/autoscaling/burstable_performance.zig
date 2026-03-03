const std = @import("std");

pub const BurstablePerformance = enum {
    included,
    excluded,
    required,

    pub const json_field_names = .{
        .included = "included",
        .excluded = "excluded",
        .required = "required",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .included => "included",
            .excluded => "excluded",
            .required => "required",
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
