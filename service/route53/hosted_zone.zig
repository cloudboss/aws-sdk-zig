const HostedZoneConfig = @import("hosted_zone_config.zig").HostedZoneConfig;
const HostedZoneFeatures = @import("hosted_zone_features.zig").HostedZoneFeatures;
const LinkedService = @import("linked_service.zig").LinkedService;

/// A complex type that contains general information about the hosted zone.
pub const HostedZone = struct {
    /// The value that you specified for `CallerReference` when you created the
    /// hosted zone.
    caller_reference: []const u8,

    /// A complex type that includes the `Comment` and `PrivateZone`
    /// elements. If you omitted the `HostedZoneConfig` and `Comment`
    /// elements from the request, the `Config` and `Comment` elements
    /// don't appear in the response.
    config: ?HostedZoneConfig = null,

    /// The features configuration for the hosted zone, including accelerated
    /// recovery settings and status information.
    features: ?HostedZoneFeatures = null,

    /// The ID that Amazon Route 53 assigned to the hosted zone when you created it.
    id: []const u8,

    /// If the hosted zone was created by another service, the service that created
    /// the hosted
    /// zone. When a hosted zone is created by another service, you can't edit or
    /// delete it
    /// using Route 53.
    linked_service: ?LinkedService = null,

    /// The name of the domain. For public hosted zones, this is the name that you
    /// have
    /// registered with your DNS registrar.
    ///
    /// For information about how to specify characters other than `a-z`,
    /// `0-9`, and `-` (hyphen) and how to specify internationalized
    /// domain names, see
    /// [CreateHostedZone](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CreateHostedZone.html).
    name: []const u8,

    /// The number of resource record sets in the hosted zone.
    resource_record_set_count: ?i64 = null,
};
