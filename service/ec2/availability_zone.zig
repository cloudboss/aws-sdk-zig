const AvailabilityZoneMessage = @import("availability_zone_message.zig").AvailabilityZoneMessage;
const AvailabilityZoneOptInStatus = @import("availability_zone_opt_in_status.zig").AvailabilityZoneOptInStatus;
const AvailabilityZoneState = @import("availability_zone_state.zig").AvailabilityZoneState;

/// Describes Availability Zones, Local Zones, and Wavelength Zones.
pub const AvailabilityZone = struct {
    /// The long name of the Availability Zone group, Local Zone group, or
    /// Wavelength Zone
    /// group.
    group_long_name: ?[]const u8 = null,

    /// The name of the zone group. For example:
    ///
    /// * Availability Zones - `us-east-1-zg-1`
    ///
    /// * Local Zones - `us-west-2-lax-1`
    ///
    /// * Wavelength Zones - `us-east-1-wl1-bos-wlz-1`
    group_name: ?[]const u8 = null,

    /// Any messages about the Availability Zone, Local Zone, or Wavelength Zone.
    messages: ?[]const AvailabilityZoneMessage = null,

    /// The name of the network border group.
    network_border_group: ?[]const u8 = null,

    /// For Availability Zones, this parameter always has the value of
    /// `opt-in-not-required`.
    ///
    /// For Local Zones and Wavelength Zones, this parameter is the opt-in status.
    /// The possible
    /// values are `opted-in` and `not-opted-in`.
    opt_in_status: ?AvailabilityZoneOptInStatus = null,

    /// The ID of the zone that handles some of the Local Zone or Wavelength Zone
    /// control plane
    /// operations, such as API calls.
    parent_zone_id: ?[]const u8 = null,

    /// The name of the zone that handles some of the Local Zone or Wavelength Zone
    /// control plane
    /// operations, such as API calls.
    parent_zone_name: ?[]const u8 = null,

    /// The name of the Region.
    region_name: ?[]const u8 = null,

    /// The state of the Availability Zone, Local Zone, or Wavelength Zone. The
    /// possible values are
    /// `available`, `unavailable`, and `constrained`.
    state: ?AvailabilityZoneState = null,

    /// The ID of the Availability Zone, Local Zone, or Wavelength Zone.
    zone_id: ?[]const u8 = null,

    /// The name of the Availability Zone, Local Zone, or Wavelength Zone.
    zone_name: ?[]const u8 = null,

    /// The type of zone.
    ///
    /// Valid values: `availability-zone` | `local-zone` |
    /// `wavelength-zone`
    zone_type: ?[]const u8 = null,
};
