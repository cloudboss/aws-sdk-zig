const Ec2MarketType = @import("ec_2_market_type.zig").Ec2MarketType;

/// The details of the Amazon EC2 instance market options for a service managed
/// fleet.
pub const ServiceManagedEc2InstanceMarketOptions = struct {
    /// The Amazon EC2 instance type.
    @"type": Ec2MarketType,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
