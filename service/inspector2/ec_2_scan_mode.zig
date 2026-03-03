const std = @import("std");

pub const Ec2ScanMode = enum {
    ec2_ssm_agent_based,
    ec2_hybrid,

    pub const json_field_names = .{
        .ec2_ssm_agent_based = "EC2_SSM_AGENT_BASED",
        .ec2_hybrid = "EC2_HYBRID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_ssm_agent_based => "EC2_SSM_AGENT_BASED",
            .ec2_hybrid => "EC2_HYBRID",
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
