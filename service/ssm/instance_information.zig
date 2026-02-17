const InstanceAggregatedAssociationOverview = @import("instance_aggregated_association_overview.zig").InstanceAggregatedAssociationOverview;
const PingStatus = @import("ping_status.zig").PingStatus;
const PlatformType = @import("platform_type.zig").PlatformType;
const ResourceType = @import("resource_type.zig").ResourceType;
const SourceType = @import("source_type.zig").SourceType;

/// Describes a filter for a specific list of managed nodes.
pub const InstanceInformation = struct {
    /// The activation ID created by Amazon Web Services Systems Manager when the
    /// server or virtual machine (VM) was
    /// registered.
    activation_id: ?[]const u8,

    /// The version of SSM Agent running on your Linux managed node.
    agent_version: ?[]const u8,

    /// Information about the association.
    association_overview: ?InstanceAggregatedAssociationOverview,

    /// The status of the association.
    association_status: ?[]const u8,

    /// The fully qualified host name of the managed node.
    computer_name: ?[]const u8,

    /// The role assigned to an Amazon EC2 instance configured with a Systems
    /// Manager
    /// Quick Setup host management configuration or the role assigned to an
    /// on-premises managed
    /// node.
    ///
    /// This call doesn't return the IAM role for *unmanaged*
    /// Amazon EC2 instances (instances not configured for Systems Manager). To
    /// retrieve the
    /// role for an unmanaged instance, use the Amazon EC2 `DescribeInstances`
    /// operation. For
    /// information, see
    /// [DescribeInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html) in the
    /// *Amazon EC2 API Reference* or
    /// [describe-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html) in the
    /// *Amazon Web Services CLI Command Reference*.
    iam_role: ?[]const u8,

    /// The managed node ID.
    instance_id: ?[]const u8,

    /// The IP address of the managed node.
    ip_address: ?[]const u8,

    /// Indicates whether the latest version of SSM Agent is running on your Linux
    /// managed node. This
    /// field doesn't indicate whether or not the latest version is installed on
    /// Windows managed nodes,
    /// because some older versions of Windows Server use the EC2Config service to
    /// process Systems Manager
    /// requests.
    is_latest_version: ?bool,

    /// The date the association was last run.
    last_association_execution_date: ?i64,

    /// The date and time when the agent last pinged the Systems Manager service.
    last_ping_date_time: ?i64,

    /// The last date the association was successfully run.
    last_successful_association_execution_date: ?i64,

    /// The name assigned to an on-premises server, edge device, or virtual machine
    /// (VM) when it is
    /// activated as a Systems Manager managed node. The name is specified as the
    /// `DefaultInstanceName`
    /// property using the CreateActivation command. It is applied to the managed
    /// node
    /// by specifying the Activation Code and Activation ID when you install SSM
    /// Agent on the node, as
    /// explained in [How to
    /// install SSM Agent on hybrid Linux
    /// nodes](https://docs.aws.amazon.com/systems-manager/latest/userguide/hybrid-multicloud-ssm-agent-install-linux.html) and [How to
    /// install SSM Agent on hybrid Windows Server
    /// nodes](https://docs.aws.amazon.com/systems-manager/latest/userguide/hybrid-multicloud-ssm-agent-install-windows.html). To retrieve the `Name` tag
    /// of an EC2 instance, use the Amazon EC2 `DescribeInstances` operation. For
    /// information, see
    /// [DescribeInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances.html) in the *Amazon EC2 API Reference* or [describe-instances](https://docs.aws.amazon.com/cli/latest/reference/ec2/describe-instances.html) in the *Amazon Web Services CLI Command Reference*.
    name: ?[]const u8,

    /// Connection status of SSM Agent.
    ///
    /// The status `Inactive` has been deprecated and is no longer in use.
    ping_status: ?PingStatus,

    /// The name of the operating system platform running on your managed node.
    platform_name: ?[]const u8,

    /// The operating system platform type.
    platform_type: ?PlatformType,

    /// The version of the OS platform running on your managed node.
    platform_version: ?[]const u8,

    /// The date the server or VM was registered with Amazon Web Services as a
    /// managed node.
    registration_date: ?i64,

    /// The type of instance. Instances are either EC2 instances or managed
    /// instances.
    resource_type: ?ResourceType,

    /// The ID of the source resource. For IoT Greengrass devices, `SourceId` is
    /// the Thing name.
    source_id: ?[]const u8,

    /// The type of the source resource. For IoT Greengrass devices, `SourceType`
    /// is `AWS::IoT::Thing`.
    source_type: ?SourceType,

    pub const json_field_names = .{
        .activation_id = "ActivationId",
        .agent_version = "AgentVersion",
        .association_overview = "AssociationOverview",
        .association_status = "AssociationStatus",
        .computer_name = "ComputerName",
        .iam_role = "IamRole",
        .instance_id = "InstanceId",
        .ip_address = "IPAddress",
        .is_latest_version = "IsLatestVersion",
        .last_association_execution_date = "LastAssociationExecutionDate",
        .last_ping_date_time = "LastPingDateTime",
        .last_successful_association_execution_date = "LastSuccessfulAssociationExecutionDate",
        .name = "Name",
        .ping_status = "PingStatus",
        .platform_name = "PlatformName",
        .platform_type = "PlatformType",
        .platform_version = "PlatformVersion",
        .registration_date = "RegistrationDate",
        .resource_type = "ResourceType",
        .source_id = "SourceId",
        .source_type = "SourceType",
    };
};
