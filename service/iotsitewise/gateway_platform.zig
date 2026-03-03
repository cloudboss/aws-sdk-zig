const Greengrass = @import("greengrass.zig").Greengrass;
const GreengrassV2 = @import("greengrass_v2.zig").GreengrassV2;
const SiemensIE = @import("siemens_ie.zig").SiemensIE;

/// The gateway's platform configuration. You can only specify one platform type
/// in a
/// gateway.
///
/// (Legacy only) For Greengrass V1 gateways, specify the `greengrass` parameter
/// with a valid Greengrass group ARN.
///
/// For Greengrass V2 gateways, specify the `greengrassV2` parameter with a
/// valid
/// core device thing name. If creating a V3 gateway (`gatewayVersion=3`), you
/// must
/// also specify the `coreDeviceOperatingSystem`.
///
/// For Siemens Industrial Edge gateways, specify the `siemensIE` parameter with
/// a
/// valid IoT Core thing name.
pub const GatewayPlatform = struct {
    /// A gateway that runs on IoT Greengrass.
    greengrass: ?Greengrass = null,

    /// A gateway that runs on IoT Greengrass V2.
    greengrass_v2: ?GreengrassV2 = null,

    /// A SiteWise Edge gateway that runs on a Siemens Industrial Edge Device.
    siemens_ie: ?SiemensIE = null,

    pub const json_field_names = .{
        .greengrass = "greengrass",
        .greengrass_v2 = "greengrassV2",
        .siemens_ie = "siemensIE",
    };
};
