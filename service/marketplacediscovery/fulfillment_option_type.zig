const std = @import("std");

pub const FulfillmentOptionType = enum {
    amazon_machine_image,
    api,
    cloudformation_template,
    container,
    helm,
    eks_add_on,
    ec2_image_builder_component,
    data_exchange,
    professional_services,
    saas,
    sagemaker_algorithm,
    sagemaker_model,

    pub const json_field_names = .{
        .amazon_machine_image = "AMAZON_MACHINE_IMAGE",
        .api = "API",
        .cloudformation_template = "CLOUDFORMATION_TEMPLATE",
        .container = "CONTAINER",
        .helm = "HELM",
        .eks_add_on = "EKS_ADD_ON",
        .ec2_image_builder_component = "EC2_IMAGE_BUILDER_COMPONENT",
        .data_exchange = "DATA_EXCHANGE",
        .professional_services = "PROFESSIONAL_SERVICES",
        .saas = "SAAS",
        .sagemaker_algorithm = "SAGEMAKER_ALGORITHM",
        .sagemaker_model = "SAGEMAKER_MODEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .amazon_machine_image => "AMAZON_MACHINE_IMAGE",
            .api => "API",
            .cloudformation_template => "CLOUDFORMATION_TEMPLATE",
            .container => "CONTAINER",
            .helm => "HELM",
            .eks_add_on => "EKS_ADD_ON",
            .ec2_image_builder_component => "EC2_IMAGE_BUILDER_COMPONENT",
            .data_exchange => "DATA_EXCHANGE",
            .professional_services => "PROFESSIONAL_SERVICES",
            .saas => "SAAS",
            .sagemaker_algorithm => "SAGEMAKER_ALGORITHM",
            .sagemaker_model => "SAGEMAKER_MODEL",
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
