const std = @import("std");

/// The type of the metric. Valid values: `AWS_MANAGED` | `CUSTOMER_MANAGED`.
pub const MetricType = enum {
    aws_managed,
    customer_managed,

    pub const json_field_names = .{
        .aws_managed = "AWS_MANAGED",
        .customer_managed = "CUSTOMER_MANAGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_managed => "AWS_MANAGED",
            .customer_managed => "CUSTOMER_MANAGED",
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
