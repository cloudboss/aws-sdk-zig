const std = @import("std");

pub const CoverageResourceType = enum {
    aws_ec2_instance,
    aws_ecr_container_image,
    aws_ecr_repository,
    aws_lambda_function,
    code_repository,
    microsoft_compute_virtual_machines,
    microsoft_container_registry_registry_container_image,
    microsoft_container_registry_registry_container_repository,
    microsoft_web_sites,
    microsoft_container_registry_registries,

    pub const json_field_names = .{
        .aws_ec2_instance = "AWS_EC2_INSTANCE",
        .aws_ecr_container_image = "AWS_ECR_CONTAINER_IMAGE",
        .aws_ecr_repository = "AWS_ECR_REPOSITORY",
        .aws_lambda_function = "AWS_LAMBDA_FUNCTION",
        .code_repository = "CODE_REPOSITORY",
        .microsoft_compute_virtual_machines = "Microsoft.Compute/virtualMachines",
        .microsoft_container_registry_registry_container_image = "Microsoft.ContainerRegistry/registry/containerImage",
        .microsoft_container_registry_registry_container_repository = "Microsoft.ContainerRegistry/registry/containerRepository",
        .microsoft_web_sites = "Microsoft.Web/sites",
        .microsoft_container_registry_registries = "Microsoft.ContainerRegistry/registries",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_ec2_instance => "AWS_EC2_INSTANCE",
            .aws_ecr_container_image => "AWS_ECR_CONTAINER_IMAGE",
            .aws_ecr_repository => "AWS_ECR_REPOSITORY",
            .aws_lambda_function => "AWS_LAMBDA_FUNCTION",
            .code_repository => "CODE_REPOSITORY",
            .microsoft_compute_virtual_machines => "Microsoft.Compute/virtualMachines",
            .microsoft_container_registry_registry_container_image => "Microsoft.ContainerRegistry/registry/containerImage",
            .microsoft_container_registry_registry_container_repository => "Microsoft.ContainerRegistry/registry/containerRepository",
            .microsoft_web_sites => "Microsoft.Web/sites",
            .microsoft_container_registry_registries => "Microsoft.ContainerRegistry/registries",
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
