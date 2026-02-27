/// A row for a top contributor for a scope.
pub const WorkloadInsightsTopContributorsRow = struct {
    /// The account ID for a specific row of data.
    account_id: ?[]const u8,

    /// The identifier for the Availability Zone where the local resource is
    /// located.
    local_az: ?[]const u8,

    /// The Amazon Web Services Region where the local resource is located.
    local_region: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a local subnet.
    local_subnet_arn: ?[]const u8,

    /// The subnet identifier for the local resource.
    local_subnet_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of a local VPC.
    local_vpc_arn: ?[]const u8,

    /// The identifier for the VPC for the local resource.
    local_vpc_id: ?[]const u8,

    /// The identifier of a remote resource. For a VPC or subnet, this identifier is
    /// the VPC Amazon Resource Name (ARN) or subnet ARN. For an Availability Zone,
    /// this identifier is the AZ name, for example, us-west-2b. For an Amazon Web
    /// Services Region , this identifier is the Region name, for example,
    /// us-west-2.
    remote_identifier: ?[]const u8,

    /// The value for a metric.
    value: ?i64,

    pub const json_field_names = .{
        .account_id = "accountId",
        .local_az = "localAz",
        .local_region = "localRegion",
        .local_subnet_arn = "localSubnetArn",
        .local_subnet_id = "localSubnetId",
        .local_vpc_arn = "localVpcArn",
        .local_vpc_id = "localVpcId",
        .remote_identifier = "remoteIdentifier",
        .value = "value",
    };
};
