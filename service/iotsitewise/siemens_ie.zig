/// Contains details for a SiteWise Edge gateway that runs on a Siemens
/// Industrial Edge
/// Device.
pub const SiemensIE = struct {
    /// The name of the IoT Thing for your SiteWise Edge gateway.
    iot_core_thing_name: []const u8,

    pub const json_field_names = .{
        .iot_core_thing_name = "iotCoreThingName",
    };
};
