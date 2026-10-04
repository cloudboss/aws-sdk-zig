const std = @import("std");

pub const DomainType = enum {
    endpoint,
    aws_managed,
    customer_managed,

    pub const json_field_names = .{
        .endpoint = "ENDPOINT",
        .aws_managed = "AWS_MANAGED",
        .customer_managed = "CUSTOMER_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .endpoint => "ENDPOINT",
            .aws_managed => "AWS_MANAGED",
            .customer_managed => "CUSTOMER_MANAGED",
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
