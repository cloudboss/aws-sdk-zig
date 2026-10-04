const std = @import("std");

pub const IndonesiaTaxRegistrationNumberType = enum {
    nik,
    passport_number,
    npwp,
    nitku,

    pub const json_field_names = .{
        .nik = "NIK",
        .passport_number = "PassportNumber",
        .npwp = "NPWP",
        .nitku = "NITKU",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nik => "NIK",
            .passport_number => "PassportNumber",
            .npwp => "NPWP",
            .nitku => "NITKU",
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
