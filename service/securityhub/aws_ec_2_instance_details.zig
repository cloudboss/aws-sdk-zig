const AwsEc2InstanceMetadataOptions = @import("aws_ec_2_instance_metadata_options.zig").AwsEc2InstanceMetadataOptions;
const AwsEc2InstanceMonitoringDetails = @import("aws_ec_2_instance_monitoring_details.zig").AwsEc2InstanceMonitoringDetails;
const AwsEc2InstanceNetworkInterfacesDetails = @import("aws_ec_2_instance_network_interfaces_details.zig").AwsEc2InstanceNetworkInterfacesDetails;

/// The details of an Amazon EC2 instance.
pub const AwsEc2InstanceDetails = struct {
    /// The IAM profile ARN of the instance.
    iam_instance_profile_arn: ?[]const u8,

    /// The Amazon Machine Image (AMI) ID of the instance.
    image_id: ?[]const u8,

    /// The IPv4 addresses associated with the instance.
    ip_v4_addresses: ?[]const []const u8,

    /// The IPv6 addresses associated with the instance.
    ip_v6_addresses: ?[]const []const u8,

    /// The key name associated with the instance.
    key_name: ?[]const u8,

    /// Indicates when the instance was launched.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    launched_at: ?[]const u8,

    /// Details about the metadata options for the Amazon EC2 instance.
    metadata_options: ?AwsEc2InstanceMetadataOptions,

    /// Describes the type of monitoring that’s turned on for an instance.
    monitoring: ?AwsEc2InstanceMonitoringDetails,

    /// The identifiers of the network interfaces for the EC2 instance. The details
    /// for each network interface are in a corresponding
    /// `AwsEc2NetworkInterfacesDetails` object.
    network_interfaces: ?[]const AwsEc2InstanceNetworkInterfacesDetails,

    /// The identifier of the subnet that the instance was launched in.
    subnet_id: ?[]const u8,

    /// The instance type of the instance.
    @"type": ?[]const u8,

    /// The virtualization type of the Amazon Machine Image (AMI) required to launch
    /// the instance.
    virtualization_type: ?[]const u8,

    /// The identifier of the VPC that the instance was launched in.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .iam_instance_profile_arn = "IamInstanceProfileArn",
        .image_id = "ImageId",
        .ip_v4_addresses = "IpV4Addresses",
        .ip_v6_addresses = "IpV6Addresses",
        .key_name = "KeyName",
        .launched_at = "LaunchedAt",
        .metadata_options = "MetadataOptions",
        .monitoring = "Monitoring",
        .network_interfaces = "NetworkInterfaces",
        .subnet_id = "SubnetId",
        .@"type" = "Type",
        .virtualization_type = "VirtualizationType",
        .vpc_id = "VpcId",
    };
};
