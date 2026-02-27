const InstanceRoleType = @import("instance_role_type.zig").InstanceRoleType;
const MarketType = @import("market_type.zig").MarketType;
const InstanceGroupState = @import("instance_group_state.zig").InstanceGroupState;

/// Detailed information about an instance group.
pub const InstanceGroupDetail = struct {
    /// The bid price for each Amazon EC2 Spot Instance type as defined by
    /// `InstanceType`. Expressed in USD. If neither `BidPrice` nor
    /// `BidPriceAsPercentageOfOnDemandPrice` is provided,
    /// `BidPriceAsPercentageOfOnDemandPrice` defaults to 100%.
    bid_price: ?[]const u8,

    /// The date/time the instance group was created.
    creation_date_time: i64,

    /// The custom AMI ID to use for the provisioned instance group.
    custom_ami_id: ?[]const u8,

    /// The date/time the instance group was terminated.
    end_date_time: ?i64,

    /// Unique identifier for the instance group.
    instance_group_id: ?[]const u8,

    /// Target number of instances to run in the instance group.
    instance_request_count: i32,

    /// Instance group role in the cluster
    instance_role: InstanceRoleType,

    /// Actual count of running instances.
    instance_running_count: i32,

    /// Amazon EC2 instance type.
    instance_type: []const u8,

    /// Details regarding the state of the instance group.
    last_state_change_reason: ?[]const u8,

    /// Market type of the Amazon EC2 instances used to create a cluster node.
    market: MarketType,

    /// Friendly name for the instance group.
    name: ?[]const u8,

    /// The date/time the instance group was available to the cluster.
    ready_date_time: ?i64,

    /// The date/time the instance group was started.
    start_date_time: ?i64,

    /// State of instance group. The following values are no longer supported:
    /// STARTING,
    /// TERMINATED, and FAILED.
    state: InstanceGroupState,

    pub const json_field_names = .{
        .bid_price = "BidPrice",
        .creation_date_time = "CreationDateTime",
        .custom_ami_id = "CustomAmiId",
        .end_date_time = "EndDateTime",
        .instance_group_id = "InstanceGroupId",
        .instance_request_count = "InstanceRequestCount",
        .instance_role = "InstanceRole",
        .instance_running_count = "InstanceRunningCount",
        .instance_type = "InstanceType",
        .last_state_change_reason = "LastStateChangeReason",
        .market = "Market",
        .name = "Name",
        .ready_date_time = "ReadyDateTime",
        .start_date_time = "StartDateTime",
        .state = "State",
    };
};
