const InstanceType = @import("instance_type.zig").InstanceType;
const RIProductDescription = @import("ri_product_description.zig").RIProductDescription;

/// The maximum price per unit hour that you are willing to pay for a Spot
/// Instance. We do not recommend
/// using this parameter because it can lead to increased interruptions. If you
/// do not specify this parameter, you will pay the current Spot price.
///
/// If you specify a maximum price, your instances will be interrupted more
/// frequently than if you do not specify this parameter.
pub const SpotPrice = struct {
    /// The Availability Zone.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// The instance type.
    instance_type: ?InstanceType = null,

    /// A general description of the AMI.
    product_description: ?RIProductDescription = null,

    /// The maximum price per unit hour that you are willing to pay for a Spot
    /// Instance. We do not recommend
    /// using this parameter because it can lead to increased interruptions. If you
    /// do not specify this parameter, you will pay the current Spot price.
    ///
    /// If you specify a maximum price, your instances will be interrupted more
    /// frequently than if you do not specify this parameter.
    spot_price: ?[]const u8 = null,

    /// The date and time the request was created, in UTC format (for example,
    /// *YYYY*-*MM*-*DD*T*HH*:*MM*:*SS*Z).
    timestamp: ?i64 = null,
};
