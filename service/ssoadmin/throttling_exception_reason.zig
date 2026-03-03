const std = @import("std");

pub const ThrottlingExceptionReason = enum {
    kms_throttling_exception,

    pub const json_field_names = .{
        .kms_throttling_exception = "KMS_ThrottlingException",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .kms_throttling_exception => "KMS_ThrottlingException",
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
