const std = @import("std");

pub const EncryptionMode = enum {
    ecb,
    cbc,
    cfb,
    cfb1,
    cfb8,
    cfb64,
    cfb128,
    ofb,

    pub const json_field_names = .{
        .ecb = "ECB",
        .cbc = "CBC",
        .cfb = "CFB",
        .cfb1 = "CFB1",
        .cfb8 = "CFB8",
        .cfb64 = "CFB64",
        .cfb128 = "CFB128",
        .ofb = "OFB",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ecb => "ECB",
            .cbc => "CBC",
            .cfb => "CFB",
            .cfb1 => "CFB1",
            .cfb8 => "CFB8",
            .cfb64 => "CFB64",
            .cfb128 => "CFB128",
            .ofb => "OFB",
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
