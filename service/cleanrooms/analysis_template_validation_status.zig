const std = @import("std");

pub const AnalysisTemplateValidationStatus = enum {
    valid,
    invalid,
    unable_to_validate,

    pub const json_field_names = .{
        .valid = "VALID",
        .invalid = "INVALID",
        .unable_to_validate = "UNABLE_TO_VALIDATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .valid => "VALID",
            .invalid => "INVALID",
            .unable_to_validate => "UNABLE_TO_VALIDATE",
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
