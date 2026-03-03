const std = @import("std");

pub const VerificationState = enum {
    false_positive,
    benign_positive,
    true_positive,
    unknown,

    pub const json_field_names = .{
        .false_positive = "FALSE_POSITIVE",
        .benign_positive = "BENIGN_POSITIVE",
        .true_positive = "TRUE_POSITIVE",
        .unknown = "UNKNOWN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .false_positive => "FALSE_POSITIVE",
            .benign_positive => "BENIGN_POSITIVE",
            .true_positive => "TRUE_POSITIVE",
            .unknown => "UNKNOWN",
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
