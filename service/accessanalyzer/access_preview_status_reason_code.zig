const std = @import("std");

pub const AccessPreviewStatusReasonCode = enum {
    internal_error,
    invalid_configuration,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .invalid_configuration = "INVALID_CONFIGURATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .invalid_configuration => "INVALID_CONFIGURATION",
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
