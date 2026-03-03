const std = @import("std");

pub const SourceType = enum {
    aws_ec2_instance,
    aws_iot_thing,
    aws_ssm_managedinstance,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS::EC2::Instance",
        .aws_iot_thing = "AWS::IoT::Thing",
        .aws_ssm_managedinstance = "AWS::SSM::ManagedInstance",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_ec2_instance => "AWS::EC2::Instance",
            .aws_iot_thing => "AWS::IoT::Thing",
            .aws_ssm_managedinstance => "AWS::SSM::ManagedInstance",
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
