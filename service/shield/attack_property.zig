const AttackLayer = @import("attack_layer.zig").AttackLayer;
const AttackPropertyIdentifier = @import("attack_property_identifier.zig").AttackPropertyIdentifier;
const Contributor = @import("contributor.zig").Contributor;
const Unit = @import("unit.zig").Unit;

/// Details of a Shield event. This is provided as part of an AttackDetail.
pub const AttackProperty = struct {
    /// The type of Shield event that was observed. `NETWORK` indicates layer 3 and
    /// layer 4 events and `APPLICATION`
    /// indicates layer 7 events.
    ///
    /// For infrastructure
    /// layer events (L3 and L4 events), you can view metrics for top contributors
    /// in Amazon CloudWatch metrics.
    /// For more information, see [Shield metrics and
    /// alarms](https://docs.aws.amazon.com/waf/latest/developerguide/monitoring-cloudwatch.html#set-ddos-alarms)
    /// in the *WAF Developer Guide*.
    attack_layer: ?AttackLayer = null,

    /// Defines the Shield event property information that is provided. The
    /// `WORDPRESS_PINGBACK_REFLECTOR` and `WORDPRESS_PINGBACK_SOURCE`
    /// values are valid only for WordPress reflective pingback events.
    attack_property_identifier: ?AttackPropertyIdentifier = null,

    /// Contributor objects for the top five contributors to a Shield event. A
    /// contributor is a source of traffic that Shield Advanced identifies as
    /// responsible for some or all of an event.
    top_contributors: ?[]const Contributor = null,

    /// The total contributions made to this Shield event by all contributors.
    total: i64 = 0,

    /// The unit used for the `Contributor`
    /// `Value` property.
    unit: ?Unit = null,

    pub const json_field_names = .{
        .attack_layer = "AttackLayer",
        .attack_property_identifier = "AttackPropertyIdentifier",
        .top_contributors = "TopContributors",
        .total = "Total",
        .unit = "Unit",
    };
};
