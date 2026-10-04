const std = @import("std");

pub const SourceType = enum {
    aws_ec2_instance,
    aws_iot_thing,
    aws_ssm_managedinstance,
    azure_instance,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS::EC2::Instance",
        .aws_iot_thing = "AWS::IoT::Thing",
        .aws_ssm_managedinstance = "AWS::SSM::ManagedInstance",
        .azure_instance = "Microsoft.Compute/virtualMachines",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_ec2_instance => "AWS::EC2::Instance",
            .aws_iot_thing => "AWS::IoT::Thing",
            .aws_ssm_managedinstance => "AWS::SSM::ManagedInstance",
            .azure_instance => "Microsoft.Compute/virtualMachines",
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
