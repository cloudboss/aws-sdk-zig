const std = @import("std");

pub const EncryptionType = enum {
    aws_managed_key,
    customer_managed_key,

    pub const json_field_names = .{
        .aws_managed_key = "AWS_MANAGED_KEY",
        .customer_managed_key = "CUSTOMER_MANAGED_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_managed_key => "AWS_MANAGED_KEY",
            .customer_managed_key => "CUSTOMER_MANAGED_KEY",
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
