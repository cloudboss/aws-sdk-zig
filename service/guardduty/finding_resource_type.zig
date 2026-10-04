const std = @import("std");

pub const FindingResourceType = enum {
    ec2_instance,
    ec2_network_interface,
    s3_bucket,
    s3_object,
    access_key,
    eks_cluster,
    kubernetes_workload,
    container,
    ecs_cluster,
    ecs_task,
    autoscaling_auto_scaling_group,
    iam_instance_profile,
    cloudformation_stack,
    ec2_launch_template,
    ec2_vpc,
    ec2_image,
    /// An Amazon Bedrock custom model fine-tuned by the customer.
    bedrock_custom_model,
    /// An Amazon Bedrock imported model brought in from an external source.
    bedrock_imported_model,
    /// An Amazon Bedrock model with provisioned throughput.
    bedrock_provisioned_model,
    /// A deployment of an Amazon Bedrock custom model.
    bedrock_custom_model_deployment,
    /// An Amazon Bedrock inference profile that routes model invocations across
    /// Regions.
    bedrock_inference_profile,
    /// An application-scoped Amazon Bedrock inference profile used to track
    /// invocation usage.
    bedrock_application_inference_profile,
    /// A managed prompt stored in Amazon Bedrock Prompt Management.
    bedrock_prompt,
    /// An Amazon Bedrock prompt router that selects a model per request.
    bedrock_prompt_router,
    /// An Amazon Bedrock guardrail evaluated during a model invocation.
    bedrock_guardrail,
    /// An Amazon SageMaker inference endpoint.
    sagemaker_endpoint,

    pub const json_field_names = .{
        .ec2_instance = "EC2_INSTANCE",
        .ec2_network_interface = "EC2_NETWORK_INTERFACE",
        .s3_bucket = "S3_BUCKET",
        .s3_object = "S3_OBJECT",
        .access_key = "ACCESS_KEY",
        .eks_cluster = "EKS_CLUSTER",
        .kubernetes_workload = "KUBERNETES_WORKLOAD",
        .container = "CONTAINER",
        .ecs_cluster = "ECS_CLUSTER",
        .ecs_task = "ECS_TASK",
        .autoscaling_auto_scaling_group = "AUTOSCALING_AUTO_SCALING_GROUP",
        .iam_instance_profile = "IAM_INSTANCE_PROFILE",
        .cloudformation_stack = "CLOUDFORMATION_STACK",
        .ec2_launch_template = "EC2_LAUNCH_TEMPLATE",
        .ec2_vpc = "EC2_VPC",
        .ec2_image = "EC2_IMAGE",
        .bedrock_custom_model = "BEDROCK_CUSTOM_MODEL",
        .bedrock_imported_model = "BEDROCK_IMPORTED_MODEL",
        .bedrock_provisioned_model = "BEDROCK_PROVISIONED_MODEL",
        .bedrock_custom_model_deployment = "BEDROCK_CUSTOM_MODEL_DEPLOYMENT",
        .bedrock_inference_profile = "BEDROCK_INFERENCE_PROFILE",
        .bedrock_application_inference_profile = "BEDROCK_APPLICATION_INFERENCE_PROFILE",
        .bedrock_prompt = "BEDROCK_PROMPT",
        .bedrock_prompt_router = "BEDROCK_PROMPT_ROUTER",
        .bedrock_guardrail = "BEDROCK_GUARDRAIL",
        .sagemaker_endpoint = "SAGEMAKER_ENDPOINT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ec2_instance => "EC2_INSTANCE",
            .ec2_network_interface => "EC2_NETWORK_INTERFACE",
            .s3_bucket => "S3_BUCKET",
            .s3_object => "S3_OBJECT",
            .access_key => "ACCESS_KEY",
            .eks_cluster => "EKS_CLUSTER",
            .kubernetes_workload => "KUBERNETES_WORKLOAD",
            .container => "CONTAINER",
            .ecs_cluster => "ECS_CLUSTER",
            .ecs_task => "ECS_TASK",
            .autoscaling_auto_scaling_group => "AUTOSCALING_AUTO_SCALING_GROUP",
            .iam_instance_profile => "IAM_INSTANCE_PROFILE",
            .cloudformation_stack => "CLOUDFORMATION_STACK",
            .ec2_launch_template => "EC2_LAUNCH_TEMPLATE",
            .ec2_vpc => "EC2_VPC",
            .ec2_image => "EC2_IMAGE",
            .bedrock_custom_model => "BEDROCK_CUSTOM_MODEL",
            .bedrock_imported_model => "BEDROCK_IMPORTED_MODEL",
            .bedrock_provisioned_model => "BEDROCK_PROVISIONED_MODEL",
            .bedrock_custom_model_deployment => "BEDROCK_CUSTOM_MODEL_DEPLOYMENT",
            .bedrock_inference_profile => "BEDROCK_INFERENCE_PROFILE",
            .bedrock_application_inference_profile => "BEDROCK_APPLICATION_INFERENCE_PROFILE",
            .bedrock_prompt => "BEDROCK_PROMPT",
            .bedrock_prompt_router => "BEDROCK_PROMPT_ROUTER",
            .bedrock_guardrail => "BEDROCK_GUARDRAIL",
            .sagemaker_endpoint => "SAGEMAKER_ENDPOINT",
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
