const AwsEc2LaunchTemplateDataInstanceMarketOptionsSpotOptionsDetails = @import("aws_ec_2_launch_template_data_instance_market_options_spot_options_details.zig").AwsEc2LaunchTemplateDataInstanceMarketOptionsSpotOptionsDetails;

/// Provides details about the market (purchasing) option for an Amazon EC2
/// instance.
pub const AwsEc2LaunchTemplateDataInstanceMarketOptionsDetails = struct {
    /// The market type.
    market_type: ?[]const u8 = null,

    /// The options for Spot Instances.
    spot_options: ?AwsEc2LaunchTemplateDataInstanceMarketOptionsSpotOptionsDetails = null,

    pub const json_field_names = .{
        .market_type = "MarketType",
        .spot_options = "SpotOptions",
    };
};
