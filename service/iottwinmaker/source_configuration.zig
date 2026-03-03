const IotSiteWiseSourceConfiguration = @import("iot_site_wise_source_configuration.zig").IotSiteWiseSourceConfiguration;
const IotTwinMakerSourceConfiguration = @import("iot_twin_maker_source_configuration.zig").IotTwinMakerSourceConfiguration;
const S3SourceConfiguration = @import("s3_source_configuration.zig").S3SourceConfiguration;
const SourceType = @import("source_type.zig").SourceType;

/// The source configuration.
pub const SourceConfiguration = struct {
    /// The source configuration IoT SiteWise configuration.
    iot_site_wise_configuration: ?IotSiteWiseSourceConfiguration = null,

    /// The source configuration IoT TwinMaker configuration.
    iot_twin_maker_configuration: ?IotTwinMakerSourceConfiguration = null,

    /// The source configuration S3 configuration.
    s_3_configuration: ?S3SourceConfiguration = null,

    /// The source configuration type.
    @"type": SourceType,

    pub const json_field_names = .{
        .iot_site_wise_configuration = "iotSiteWiseConfiguration",
        .iot_twin_maker_configuration = "iotTwinMakerConfiguration",
        .s_3_configuration = "s3Configuration",
        .@"type" = "type",
    };
};
