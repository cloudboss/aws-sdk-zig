const std = @import("std");

pub const RecommendationStatus = enum {
    implemented,
    inactive,
    not_implemented,
    excluded,

    pub const json_field_names = .{
        .implemented = "Implemented",
        .inactive = "Inactive",
        .not_implemented = "NotImplemented",
        .excluded = "Excluded",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .implemented => "Implemented",
            .inactive => "Inactive",
            .not_implemented => "NotImplemented",
            .excluded => "Excluded",
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
