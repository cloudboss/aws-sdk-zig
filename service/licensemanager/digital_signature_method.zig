const std = @import("std");

pub const DigitalSignatureMethod = enum {
    jwt_ps384,

    pub const json_field_names = .{
        .jwt_ps384 = "JWT_PS384",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .jwt_ps384 => "JWT_PS384",
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
