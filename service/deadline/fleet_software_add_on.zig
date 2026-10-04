const FleetSoftwareAddOnName = @import("fleet_software_add_on_name.zig").FleetSoftwareAddOnName;

/// Software that the service installs on worker hosts in a service-managed
/// fleet.
pub const FleetSoftwareAddOn = struct {
    /// The name of the software add-on. The supported value is `docker`.
    name: FleetSoftwareAddOnName,

    pub const json_field_names = .{
        .name = "name",
    };
};
