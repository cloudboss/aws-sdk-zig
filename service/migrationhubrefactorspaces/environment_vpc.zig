/// Provides summary information for the `EnvironmentVpc` resource as a response
/// to
/// `ListEnvironmentVpc`.
pub const EnvironmentVpc = struct {
    /// The Amazon Web Services account ID of the virtual private cloud (VPC) owner.
    account_id: ?[]const u8 = null,

    /// The list of Amazon Virtual Private Cloud (Amazon VPC) CIDR blocks.
    cidr_blocks: ?[]const []const u8 = null,

    /// A timestamp that indicates when the VPC is first added to the environment.
    created_time: ?i64 = null,

    /// The unique identifier of the environment.
    environment_id: ?[]const u8 = null,

    /// A timestamp that indicates when the VPC was last updated by the environment.
    last_updated_time: ?i64 = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    /// The name of the VPC at the time it is added to the environment.
    vpc_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .cidr_blocks = "CidrBlocks",
        .created_time = "CreatedTime",
        .environment_id = "EnvironmentId",
        .last_updated_time = "LastUpdatedTime",
        .vpc_id = "VpcId",
        .vpc_name = "VpcName",
    };
};
