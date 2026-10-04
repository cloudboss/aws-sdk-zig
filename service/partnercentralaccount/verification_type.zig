const std = @import("std");

pub const VerificationType = enum {
    business_verification,
    registrant_verification,

    pub const json_field_names = .{
        .business_verification = "BUSINESS_VERIFICATION",
        .registrant_verification = "REGISTRANT_VERIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .business_verification => "BUSINESS_VERIFICATION",
            .registrant_verification => "REGISTRANT_VERIFICATION",
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
