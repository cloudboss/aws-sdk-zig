const std = @import("std");

pub const UsageType = enum {
    ec2_instance_hours,
    ecr_initial_scan,
    ecr_rescan,
    lambda_function_hours,
    lambda_function_code_hours,
    code_repository_sast,
    code_repository_iac,
    code_repository_sca,
    ec2_agentless_instance_hours,
    azure_container_image_initial_scan,
    azure_container_image_rescan,
    azure_vm_agent_based_instance_hours,
    azure_serverless_function_hours,

    pub const json_field_names = .{
        .ec2_instance_hours = "EC2_INSTANCE_HOURS",
        .ecr_initial_scan = "ECR_INITIAL_SCAN",
        .ecr_rescan = "ECR_RESCAN",
        .lambda_function_hours = "LAMBDA_FUNCTION_HOURS",
        .lambda_function_code_hours = "LAMBDA_FUNCTION_CODE_HOURS",
        .code_repository_sast = "CODE_REPOSITORY_SAST",
        .code_repository_iac = "CODE_REPOSITORY_IAC",
        .code_repository_sca = "CODE_REPOSITORY_SCA",
        .ec2_agentless_instance_hours = "EC2_AGENTLESS_INSTANCE_HOURS",
        .azure_container_image_initial_scan = "AZURE_CONTAINER_IMAGE_INITIAL_SCAN",
        .azure_container_image_rescan = "AZURE_CONTAINER_IMAGE_RESCAN",
        .azure_vm_agent_based_instance_hours = "AZURE_VM_AGENT_BASED_INSTANCE_HOURS",
        .azure_serverless_function_hours = "AZURE_SERVERLESS_FUNCTION_HOURS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance_hours => "EC2_INSTANCE_HOURS",
            .ecr_initial_scan => "ECR_INITIAL_SCAN",
            .ecr_rescan => "ECR_RESCAN",
            .lambda_function_hours => "LAMBDA_FUNCTION_HOURS",
            .lambda_function_code_hours => "LAMBDA_FUNCTION_CODE_HOURS",
            .code_repository_sast => "CODE_REPOSITORY_SAST",
            .code_repository_iac => "CODE_REPOSITORY_IAC",
            .code_repository_sca => "CODE_REPOSITORY_SCA",
            .ec2_agentless_instance_hours => "EC2_AGENTLESS_INSTANCE_HOURS",
            .azure_container_image_initial_scan => "AZURE_CONTAINER_IMAGE_INITIAL_SCAN",
            .azure_container_image_rescan => "AZURE_CONTAINER_IMAGE_RESCAN",
            .azure_vm_agent_based_instance_hours => "AZURE_VM_AGENT_BASED_INSTANCE_HOURS",
            .azure_serverless_function_hours => "AZURE_SERVERLESS_FUNCTION_HOURS",
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
