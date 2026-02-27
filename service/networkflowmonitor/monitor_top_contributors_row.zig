const DestinationCategory = @import("destination_category.zig").DestinationCategory;
const KubernetesMetadata = @import("kubernetes_metadata.zig").KubernetesMetadata;
const TraversedComponent = @import("traversed_component.zig").TraversedComponent;

/// A set of information for a top contributor network flow in a monitor. In a
/// monitor, Network Flow Monitor returns information about the network flows
/// for top contributors for each metric. Top contributors are network flows
/// with the top values for each metric type.
pub const MonitorTopContributorsRow = struct {
    /// The destination category for a top contributors row. Destination categories
    /// can be one of the following:
    ///
    /// * `INTRA_AZ`: Top contributor network flows within a single Availability
    ///   Zone
    /// * `INTER_AZ`: Top contributor network flows between Availability Zones
    /// * `INTER_REGION`: Top contributor network flows between Regions (to the edge
    ///   of another Region)
    /// * `INTER_VPC`: Top contributor network flows between VPCs
    /// * `AWS_SERVICES`: Top contributor network flows to or from Amazon Web
    ///   Services services
    /// * `UNCLASSIFIED`: Top contributor network flows that do not have a bucket
    ///   classification
    destination_category: ?DestinationCategory,

    /// The destination network address translation (DNAT) IP address for a top
    /// contributor network flow.
    dnat_ip: ?[]const u8,

    /// Meta data about Kubernetes resources.
    kubernetes_metadata: ?KubernetesMetadata,

    /// The Availability Zone for the local resource for a top contributor network
    /// flow.
    local_az: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a local resource.
    local_instance_arn: ?[]const u8,

    /// The instance identifier for the local resource for a top contributor network
    /// flow.
    local_instance_id: ?[]const u8,

    /// The IP address of the local resource for a top contributor network flow.
    local_ip: ?[]const u8,

    /// The Amazon Web Services Region for the local resource for a top contributor
    /// network flow.
    local_region: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a local subnet.
    local_subnet_arn: ?[]const u8,

    /// The subnet ID for the local resource for a top contributor network flow.
    local_subnet_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a local VPC.
    local_vpc_arn: ?[]const u8,

    /// The VPC ID for a top contributor network flow for the local resource.
    local_vpc_id: ?[]const u8,

    /// The Availability Zone for the remote resource for a top contributor network
    /// flow.
    remote_az: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a remote resource.
    remote_instance_arn: ?[]const u8,

    /// The instance identifier for the remote resource for a top contributor
    /// network flow.
    remote_instance_id: ?[]const u8,

    /// The IP address of the remote resource for a top contributor network flow.
    remote_ip: ?[]const u8,

    /// The Amazon Web Services Region for the remote resource for a top contributor
    /// network flow.
    remote_region: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a remote subnet.
    remote_subnet_arn: ?[]const u8,

    /// The subnet ID for the remote resource for a top contributor network flow.
    remote_subnet_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a remote VPC.
    remote_vpc_arn: ?[]const u8,

    /// The VPC ID for a top contributor network flow for the remote resource.
    remote_vpc_id: ?[]const u8,

    /// The secure network address translation (SNAT) IP address for a top
    /// contributor network flow.
    snat_ip: ?[]const u8,

    /// The target port.
    target_port: ?i32,

    /// The constructs traversed by a network flow.
    traversed_constructs: ?[]const TraversedComponent,

    /// The value of the metric for a top contributor network flow.
    value: ?i64,

    pub const json_field_names = .{
        .destination_category = "destinationCategory",
        .dnat_ip = "dnatIp",
        .kubernetes_metadata = "kubernetesMetadata",
        .local_az = "localAz",
        .local_instance_arn = "localInstanceArn",
        .local_instance_id = "localInstanceId",
        .local_ip = "localIp",
        .local_region = "localRegion",
        .local_subnet_arn = "localSubnetArn",
        .local_subnet_id = "localSubnetId",
        .local_vpc_arn = "localVpcArn",
        .local_vpc_id = "localVpcId",
        .remote_az = "remoteAz",
        .remote_instance_arn = "remoteInstanceArn",
        .remote_instance_id = "remoteInstanceId",
        .remote_ip = "remoteIp",
        .remote_region = "remoteRegion",
        .remote_subnet_arn = "remoteSubnetArn",
        .remote_subnet_id = "remoteSubnetId",
        .remote_vpc_arn = "remoteVpcArn",
        .remote_vpc_id = "remoteVpcId",
        .snat_ip = "snatIp",
        .target_port = "targetPort",
        .traversed_constructs = "traversedConstructs",
        .value = "value",
    };
};
