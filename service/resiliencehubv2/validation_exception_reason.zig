const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_field_value,
    duplicate_value,
    missing_required_field,
    other,

    pub const json_field_names = .{
        .invalid_field_value = "INVALID_FIELD_VALUE",
        .duplicate_value = "DUPLICATE_VALUE",
        .missing_required_field = "MISSING_REQUIRED_FIELD",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_field_value => "INVALID_FIELD_VALUE",
            .duplicate_value => "DUPLICATE_VALUE",
            .missing_required_field => "MISSING_REQUIRED_FIELD",
            .other => "OTHER",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
