const AbpV1_0_x = @import("abp_v1_0_x.zig").AbpV1_0_x;
const AbpV1_1 = @import("abp_v1_1.zig").AbpV1_1;
const FPorts = @import("f_ports.zig").FPorts;
const OtaaV1_0_x = @import("otaa_v1_0_x.zig").OtaaV1_0_x;
const OtaaV1_1 = @import("otaa_v1_1.zig").OtaaV1_1;

/// LoRaWAN object for create functions.
pub const LoRaWANDevice = struct {
    /// LoRaWAN object for create APIs
    abp_v1_0_x: ?AbpV1_0_x = null,

    /// ABP device object for create APIs for v1.1
    abp_v1_1: ?AbpV1_1 = null,

    /// The DevEUI value.
    dev_eui: ?[]const u8 = null,

    /// The ID of the device profile for the new wireless device.
    device_profile_id: ?[]const u8 = null,

    f_ports: ?FPorts = null,

    /// OTAA device object for create APIs for v1.0.x
    otaa_v1_0_x: ?OtaaV1_0_x = null,

    /// OTAA device object for v1.1 for create APIs
    otaa_v1_1: ?OtaaV1_1 = null,

    /// The ID of the service profile.
    service_profile_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .abp_v1_0_x = "AbpV1_0_x",
        .abp_v1_1 = "AbpV1_1",
        .dev_eui = "DevEui",
        .device_profile_id = "DeviceProfileId",
        .f_ports = "FPorts",
        .otaa_v1_0_x = "OtaaV1_0_x",
        .otaa_v1_1 = "OtaaV1_1",
        .service_profile_id = "ServiceProfileId",
    };
};
