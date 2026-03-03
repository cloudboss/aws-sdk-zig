const std = @import("std");

pub const ResourceType = enum {
    ec2_instance,
    ec2_host,
    ec2_ami,
    rds,
    systems_manager_managed_instance,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .ec2_host = "EC2_HOST",
        .ec2_ami = "EC2_AMI",
        .rds = "RDS",
        .systems_manager_managed_instance = "SYSTEMS_MANAGER_MANAGED_INSTANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance => "EC2_INSTANCE",
            .ec2_host => "EC2_HOST",
            .ec2_ami => "EC2_AMI",
            .rds => "RDS",
            .systems_manager_managed_instance => "SYSTEMS_MANAGER_MANAGED_INSTANCE",
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
