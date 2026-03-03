const ContainerFleetLocationStatus = @import("container_fleet_location_status.zig").ContainerFleetLocationStatus;

/// Details about a location in a multi-location container fleet.
pub const ContainerFleetLocationAttributes = struct {
    /// A location identifier.
    location: ?[]const u8 = null,

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
        .status = "Status",
    };
};
