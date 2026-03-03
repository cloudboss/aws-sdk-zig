const std = @import("std");

pub const CustomerAgreementState = enum {
    active,
    customer_terminated,
    aws_terminated,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .customer_terminated = "CUSTOMER_TERMINATED",
        .aws_terminated = "AWS_TERMINATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .customer_terminated => "CUSTOMER_TERMINATED",
            .aws_terminated => "AWS_TERMINATED",
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
