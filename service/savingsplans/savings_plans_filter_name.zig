const std = @import("std");

pub const SavingsPlansFilterName = enum {
    region,
    ec2_instance_family,
    commitment,
    upfront,
    term,
    savings_plan_type,
    payment_option,
    start,
    end,
    instance_family,

    pub const json_field_names = .{
        .region = "region",
        .ec2_instance_family = "ec2-instance-family",
        .commitment = "commitment",
        .upfront = "upfront",
        .term = "term",
        .savings_plan_type = "savings-plan-type",
        .payment_option = "payment-option",
        .start = "start",
        .end = "end",
        .instance_family = "instance-family",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .region => "region",
            .ec2_instance_family => "ec2-instance-family",
            .commitment => "commitment",
            .upfront => "upfront",
            .term => "term",
            .savings_plan_type => "savings-plan-type",
            .payment_option => "payment-option",
            .start => "start",
            .end => "end",
            .instance_family => "instance-family",
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
