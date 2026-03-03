const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_region_opt_target,
    field_validation_failed,

    pub const json_field_names = .{
        .invalid_region_opt_target = "invalidRegionOptTarget",
        .field_validation_failed = "fieldValidationFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_region_opt_target => "invalidRegionOptTarget",
            .field_validation_failed => "fieldValidationFailed",
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
