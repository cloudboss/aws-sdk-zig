const std = @import("std");

pub const AdditionalAnalyses = enum {
    allowed,
    required,
    not_allowed,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .required = "REQUIRED",
        .not_allowed = "NOT_ALLOWED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .allowed => "ALLOWED",
            .required => "REQUIRED",
            .not_allowed => "NOT_ALLOWED",
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
