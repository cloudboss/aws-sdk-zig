const IotEventsInputIdentifier = @import("iot_events_input_identifier.zig").IotEventsInputIdentifier;
const IotSiteWiseInputIdentifier = @import("iot_site_wise_input_identifier.zig").IotSiteWiseInputIdentifier;

/// The identifer of the input.
pub const InputIdentifier = struct {
    /// The identifier of the input routed to AWS IoT Events.
    iot_events_input_identifier: ?IotEventsInputIdentifier = null,

    /// The identifer of the input routed from AWS IoT SiteWise.
    iot_site_wise_input_identifier: ?IotSiteWiseInputIdentifier = null,

    pub const json_field_names = .{
        .iot_events_input_identifier = "iotEventsInputIdentifier",
        .iot_site_wise_input_identifier = "iotSiteWiseInputIdentifier",
    };
};
