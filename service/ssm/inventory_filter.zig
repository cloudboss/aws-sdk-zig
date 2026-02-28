const InventoryQueryOperatorType = @import("inventory_query_operator_type.zig").InventoryQueryOperatorType;

/// One or more filters. Use a filter to return a more specific list of results.
///
/// **Example formats for the `aws ssm get-inventory`
/// command:**
///
/// `--filters
/// Key=AWS:InstanceInformation.AgentType,Values=amazon-ssm-agent,Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.AgentVersion,Values=3.3.2299.0,Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.ComputerName,Values=ip-192.0.2.0.us-east-2.compute.internal,Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.InstanceId,Values=i-0a4cd6ceffEXAMPLE,i-1a2b3c4d5e6EXAMPLE,Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.InstanceStatus,Values=Active,Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.IpAddress,Values=198.51.100.0,Type=Equal`
///
/// `--filters Key=AWS:InstanceInformation.PlatformName,Values="Amazon
/// Linux",Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.PlatformType,Values=Linux,Type=Equal`
///
/// `--filters
/// Key=AWS:InstanceInformation.PlatformVersion,Values=2023,Type=BeginWith`
///
/// `--filters
/// Key=AWS:InstanceInformation.ResourceType,Values=EC2Instance,Type=Equal`
pub const InventoryFilter = struct {
    /// The name of the filter key.
    key: []const u8,

    /// The type of filter.
    ///
    /// The `Exists` filter must be used with aggregators. For more information, see
    /// [Aggregating inventory
    /// data](https://docs.aws.amazon.com/systems-manager/latest/userguide/inventory-aggregate.html) in the *Amazon Web Services Systems Manager User Guide*.
    @"type": ?InventoryQueryOperatorType,

    /// Inventory filter values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
        .values = "Values",
    };
};
