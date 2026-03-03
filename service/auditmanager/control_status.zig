const std = @import("std");

pub const ControlStatus = enum {
    under_review,
    reviewed,
    inactive,

    pub const json_field_names = .{
        .under_review = "UNDER_REVIEW",
        .reviewed = "REVIEWED",
        .inactive = "INACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .under_review => "UNDER_REVIEW",
            .reviewed => "REVIEWED",
            .inactive => "INACTIVE",
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
