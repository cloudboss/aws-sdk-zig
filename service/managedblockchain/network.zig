const aws = @import("aws");

const Framework = @import("framework.zig").Framework;
const NetworkFrameworkAttributes = @import("network_framework_attributes.zig").NetworkFrameworkAttributes;
const NetworkStatus = @import("network_status.zig").NetworkStatus;
const VotingPolicy = @import("voting_policy.zig").VotingPolicy;

/// Network configuration properties.
pub const Network = struct {
    /// The Amazon Resource Name (ARN) of the network. For more information about
    /// ARNs and their format, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The date and time that the network was created.
    creation_date: ?i64 = null,

    /// Attributes of the blockchain framework for the network.
    description: ?[]const u8 = null,

    /// The blockchain framework that the network uses.
    framework: ?Framework = null,

    /// Attributes of the blockchain framework that the network uses.
    framework_attributes: ?NetworkFrameworkAttributes = null,

    /// The version of the blockchain framework that the network uses.
    framework_version: ?[]const u8 = null,

    /// The unique identifier of the network.
    id: ?[]const u8 = null,

    /// The name of the network.
    name: ?[]const u8 = null,

    /// The current status of the network.
    status: ?NetworkStatus = null,

    /// Tags assigned to the network. Each tag consists of a key and optional value.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The voting rules that the network uses to decide if a proposal is accepted.
    voting_policy: ?VotingPolicy = null,

    /// The VPC endpoint service name of the VPC endpoint service of the network.
    /// Members use the VPC endpoint service name to create a VPC endpoint to access
    /// network resources.
    vpc_endpoint_service_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .description = "Description",
        .framework = "Framework",
        .framework_attributes = "FrameworkAttributes",
        .framework_version = "FrameworkVersion",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .voting_policy = "VotingPolicy",
        .vpc_endpoint_service_name = "VpcEndpointServiceName",
    };
};
