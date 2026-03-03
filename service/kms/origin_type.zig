const std = @import("std");

pub const OriginType = enum {
    aws_kms,
    external,
    aws_cloudhsm,
    external_key_store,

    pub const json_field_names = .{
        .aws_kms = "AWS_KMS",
        .external = "EXTERNAL",
        .aws_cloudhsm = "AWS_CLOUDHSM",
        .external_key_store = "EXTERNAL_KEY_STORE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_kms => "AWS_KMS",
            .external => "EXTERNAL",
            .aws_cloudhsm => "AWS_CLOUDHSM",
            .external_key_store => "EXTERNAL_KEY_STORE",
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
