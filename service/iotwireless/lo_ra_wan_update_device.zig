const UpdateAbpV1_0_x = @import("update_abp_v1_0_x.zig").UpdateAbpV1_0_x;
const UpdateAbpV1_1 = @import("update_abp_v1_1.zig").UpdateAbpV1_1;
const UpdateFPorts = @import("update_f_ports.zig").UpdateFPorts;

/// LoRaWAN object for update functions.
pub const LoRaWANUpdateDevice = struct {
    /// ABP device object for update APIs for v1.0.x
    abp_v1_0_x: ?UpdateAbpV1_0_x = null,

    /// ABP device object for update APIs for v1.1
    abp_v1_1: ?UpdateAbpV1_1 = null,

    /// The ID of the device profile for the wireless device.
    device_profile_id: ?[]const u8 = null,

    /// FPorts object for the positioning information of the device.
    f_ports: ?UpdateFPorts = null,

    /// The ID of the service profile.
    service_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .abp_v1_0_x = "AbpV1_0_x",
        .abp_v1_1 = "AbpV1_1",
        .device_profile_id = "DeviceProfileId",
        .f_ports = "FPorts",
        .service_profile_id = "ServiceProfileId",
    };
};
