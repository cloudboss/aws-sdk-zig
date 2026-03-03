const std = @import("std");

pub const MonitorLocalResourceType = enum {
    aws_vpc,
    aws_az,
    aws_subnet,
    aws_region,
    eks_cluster,

    pub const json_field_names = .{
        .aws_vpc = "AWS::EC2::VPC",
        .aws_az = "AWS::AvailabilityZone",
        .aws_subnet = "AWS::EC2::Subnet",
        .aws_region = "AWS::Region",
        .eks_cluster = "AWS::EKS::Cluster",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_vpc => "AWS::EC2::VPC",
            .aws_az => "AWS::AvailabilityZone",
            .aws_subnet => "AWS::EC2::Subnet",
            .aws_region => "AWS::Region",
            .eks_cluster => "AWS::EKS::Cluster",
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
