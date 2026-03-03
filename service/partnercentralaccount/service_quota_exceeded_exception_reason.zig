const std = @import("std");

pub const ServiceQuotaExceededExceptionReason = enum {
    limit_exceeded_number_of_email,
    limit_exceeded_number_of_domain,

    pub const json_field_names = .{
        .limit_exceeded_number_of_email = "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
        .limit_exceeded_number_of_domain = "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .limit_exceeded_number_of_email => "LIMIT_EXCEEDED_NUMBER_OF_EMAIL",
            .limit_exceeded_number_of_domain => "LIMIT_EXCEEDED_NUMBER_OF_DOMAIN",
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
