const AwsEcsServiceNetworkConfigurationAwsVpcConfigurationDetails = @import("aws_ecs_service_network_configuration_aws_vpc_configuration_details.zig").AwsEcsServiceNetworkConfigurationAwsVpcConfigurationDetails;

/// For tasks that use the `awsvpc` networking mode, the VPC subnet and security
/// group configuration.
pub const AwsEcsServiceNetworkConfigurationDetails = struct {
    /// The VPC subnet and security group configuration.
    aws_vpc_configuration: ?AwsEcsServiceNetworkConfigurationAwsVpcConfigurationDetails,

    pub const json_field_names = .{
        .aws_vpc_configuration = "AwsVpcConfiguration",
    };
};
