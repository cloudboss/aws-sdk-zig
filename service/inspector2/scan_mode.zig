const std = @import("std");

pub const ScanMode = enum {
    ec2_ssm_agent_based,
    ec2_agentless,
    ec2_inspector_agent_based,
    vm_inspector_agent_based,

    pub const json_field_names = .{
        .ec2_ssm_agent_based = "EC2_SSM_AGENT_BASED",
        .ec2_agentless = "EC2_AGENTLESS",
        .ec2_inspector_agent_based = "EC2_INSPECTOR_AGENT_BASED",
        .vm_inspector_agent_based = "VM_INSPECTOR_AGENT_BASED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_ssm_agent_based => "EC2_SSM_AGENT_BASED",
            .ec2_agentless => "EC2_AGENTLESS",
            .ec2_inspector_agent_based => "EC2_INSPECTOR_AGENT_BASED",
            .vm_inspector_agent_based => "VM_INSPECTOR_AGENT_BASED",
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
