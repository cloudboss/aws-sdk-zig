const PlayerGatewayStatus = @import("player_gateway_status.zig").PlayerGatewayStatus;
const FleetStatus = @import("fleet_status.zig").FleetStatus;

/// A fleet location and its life-cycle state. A location state object might be
/// used to
/// describe a fleet's remote location or home Region. Life-cycle state tracks
/// the progress
/// of launching the first instance in a new location and preparing it for game
/// hosting, and
/// then removing all instances and deleting the location from the fleet.
///
/// * **NEW** -- A new fleet location has been defined and desired
/// instances is set to 1.
///
/// * **DOWNLOADING/VALIDATING/BUILDING/ACTIVATING** --
/// Amazon GameLift Servers is setting up the new fleet location, creating new
/// instances with the game build
/// or Realtime script and starting server processes.
///
/// * **ACTIVE** -- Hosts can now accept game
/// sessions.
///
/// * **ERROR** -- An error occurred when downloading,
/// validating, building, or activating the fleet location.
///
/// * **DELETING** -- Hosts are responding to a delete
/// fleet location request.
///
/// * **TERMINATED** -- The fleet location no longer
/// exists.
///
/// * **NOT_FOUND** -- The fleet location was not found. This could be because
///   the custom location was removed or not created.
pub const LocationState = struct {
    /// The fleet location, expressed as an Amazon Web Services Region code such as
    /// `us-west-2`.
    location: ?[]const u8 = null,

    /// The current status of player gateway in this location for this fleet. Note,
    /// even if a fleet has PlayerGatewayMode configured as `ENABLED`, player
    /// gateway might not be available in a specific location. For more information
    /// about locations where player gateway is supported, see [Amazon GameLift
    /// Servers service
    /// locations](https://docs.aws.amazon.com/gameliftservers/latest/developerguide/gamelift-regions.html).
    ///
    /// Possible values include:
    ///
    /// * `ENABLED` -- Player gateway is available for this fleet location.
    ///
    /// * `DISABLED` -- Player gateway is not available for this fleet location.
    player_gateway_status: ?PlayerGatewayStatus = null,

    /// The life-cycle status of a fleet location.
    status: ?FleetStatus = null,

    pub const json_field_names = .{
        .location = "Location",
        .player_gateway_status = "PlayerGatewayStatus",
        .status = "Status",
    };
};
