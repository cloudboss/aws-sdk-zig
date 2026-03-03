const AwsRoute53HostedZoneConfigDetails = @import("aws_route_53_hosted_zone_config_details.zig").AwsRoute53HostedZoneConfigDetails;

/// An object that contains information about an Amazon Route 53 hosted zone.
pub const AwsRoute53HostedZoneObjectDetails = struct {
    /// An object that includes the `Comment` element.
    config: ?AwsRoute53HostedZoneConfigDetails = null,

    /// The ID that Route 53 assigns to the hosted zone when you create it.
    id: ?[]const u8 = null,

    /// The name of the domain. For public hosted zones, this is the name that you
    /// have registered with your DNS registrar.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .config = "Config",
        .id = "Id",
        .name = "Name",
    };
};
