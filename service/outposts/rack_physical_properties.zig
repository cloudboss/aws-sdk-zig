const FiberOpticCableType = @import("fiber_optic_cable_type.zig").FiberOpticCableType;
const MaximumSupportedWeightLbs = @import("maximum_supported_weight_lbs.zig").MaximumSupportedWeightLbs;
const OpticalStandard = @import("optical_standard.zig").OpticalStandard;
const PowerConnector = @import("power_connector.zig").PowerConnector;
const PowerDrawKva = @import("power_draw_kva.zig").PowerDrawKva;
const PowerFeedDrop = @import("power_feed_drop.zig").PowerFeedDrop;
const PowerPhase = @import("power_phase.zig").PowerPhase;
const UplinkCount = @import("uplink_count.zig").UplinkCount;
const UplinkGbps = @import("uplink_gbps.zig").UplinkGbps;

/// Information about the physical and logistical details for racks at sites.
/// For more information
/// about hardware requirements for racks, see [Network
/// readiness
/// checklist](https://docs.aws.amazon.com/outposts/latest/userguide/outposts-requirements.html#checklist) in the Amazon Web Services Outposts User Guide.
pub const RackPhysicalProperties = struct {
    /// The type of fiber used to attach the Outpost to the network.
    fiber_optic_cable_type: ?FiberOpticCableType,

    /// The maximum rack weight that this site can support. `NO_LIMIT` is over 2000
    /// lbs
    /// (907 kg).
    maximum_supported_weight_lbs: ?MaximumSupportedWeightLbs,

    /// The type of optical standard used to attach the Outpost to the network. This
    /// field is
    /// dependent on uplink speed, fiber type, and distance to the upstream device.
    /// For more information
    /// about networking requirements for racks, see
    /// [Network](https://docs.aws.amazon.com/outposts/latest/userguide/outposts-requirements.html#facility-networking)
    /// in the Amazon Web Services Outposts User Guide.
    optical_standard: ?OpticalStandard,

    /// The power connector for the hardware.
    power_connector: ?PowerConnector,

    /// The power draw available at the hardware placement position for the rack.
    power_draw_kva: ?PowerDrawKva,

    /// The position of the power feed.
    power_feed_drop: ?PowerFeedDrop,

    /// The power option that you can provide for hardware.
    power_phase: ?PowerPhase,

    /// The number of uplinks each Outpost network device.
    uplink_count: ?UplinkCount,

    /// The uplink speed the rack supports for the connection to the Region.
    uplink_gbps: ?UplinkGbps,

    pub const json_field_names = .{
        .fiber_optic_cable_type = "FiberOpticCableType",
        .maximum_supported_weight_lbs = "MaximumSupportedWeightLbs",
        .optical_standard = "OpticalStandard",
        .power_connector = "PowerConnector",
        .power_draw_kva = "PowerDrawKva",
        .power_feed_drop = "PowerFeedDrop",
        .power_phase = "PowerPhase",
        .uplink_count = "UplinkCount",
        .uplink_gbps = "UplinkGbps",
    };
};
