const PlayerGatewayStatus = @import("player_gateway_status.zig").PlayerGatewayStatus;
const ContainerFleetLocationStatus = @import("container_fleet_location_status.zig").ContainerFleetLocationStatus;

/// Details about a location in a multi-location container fleet.
pub const ContainerFleetLocationAttributes = struct {
    /// A location identifier.
    location: ?[]const u8 = null,

    /// The current status of player gateway in this location for this container
    /// fleet. Note, even if a container fleet has PlayerGatewayMode configured as
    /// `ENABLED`, player gateway might not be available in a specific location. For
    /// more information about locations where player gateway is supported, see
    /// [Amazon GameLift Servers service
    /// locations](https://docs.aws.amazon.com/gameliftservers/latest/developerguide/gamelift-regions.html).
    ///
    /// Possible values include:
    ///
    /// * `ENABLED` -- Player gateway is available for this container fleet
    ///   location.
    ///
    /// * `DISABLED` -- Player gateway is not available for this container fleet
    ///   location.
    player_gateway_status: ?PlayerGatewayStatus = null,

    /// The status of fleet activity in the location.
    ///
    /// * `PENDING` -- A new container fleet has been requested.
    ///
    /// * `CREATING` -- A new container fleet resource is being created.
    ///
    /// * `CREATED` -- A new container fleet resource has been created. No
    /// fleet instances have been deployed.
    ///
    /// * `ACTIVATING` -- New container fleet instances are being
    /// deployed.
    ///
    /// * `ACTIVE` -- The container fleet has been deployed and is ready to
    /// host game sessions.
    ///
    /// * `UPDATING` -- Updates to the container fleet is being updated. A
    /// deployment is in progress.
    status: ?ContainerFleetLocationStatus = null,

    pub const json_field_names = .{
        .location = "Location",
        .player_gateway_status = "PlayerGatewayStatus",
        .status = "Status",
    };
};
