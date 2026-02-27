pub const ScanMode = enum {
    ec2_ssm_agent_based,
    ec2_agentless,

    pub const json_field_names = .{
        .ec2_ssm_agent_based = "EC2_SSM_AGENT_BASED",
        .ec2_agentless = "EC2_AGENTLESS",
    };
};
