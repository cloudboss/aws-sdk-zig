const std = @import("std");

pub const AdapterVersionStatus = enum {
    active,
    at_risk,
    deprecated,
    creation_error,
    creation_in_progress,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .at_risk = "AT_RISK",
        .deprecated = "DEPRECATED",
        .creation_error = "CREATION_ERROR",
        .creation_in_progress = "CREATION_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .at_risk => "AT_RISK",
            .deprecated => "DEPRECATED",
            .creation_error => "CREATION_ERROR",
            .creation_in_progress => "CREATION_IN_PROGRESS",
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
