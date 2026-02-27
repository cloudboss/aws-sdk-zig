const aws = @import("aws");

const Authorization = @import("authorization.zig").Authorization;
const CmafPackage = @import("cmaf_package.zig").CmafPackage;
const DashPackage = @import("dash_package.zig").DashPackage;
const HlsPackage = @import("hls_package.zig").HlsPackage;
const MssPackage = @import("mss_package.zig").MssPackage;
const Origination = @import("origination.zig").Origination;

/// An OriginEndpoint resource configuration.
pub const OriginEndpoint = struct {
    /// The Amazon Resource Name (ARN) assigned to the OriginEndpoint.
    arn: ?[]const u8,

    authorization: ?Authorization,

    /// The ID of the Channel the OriginEndpoint is associated with.
    channel_id: ?[]const u8,

    cmaf_package: ?CmafPackage,

    /// The date and time the OriginEndpoint was created.
    created_at: ?[]const u8,

    dash_package: ?DashPackage,

    /// A short text description of the OriginEndpoint.
    description: ?[]const u8,

    hls_package: ?HlsPackage,

    /// The ID of the OriginEndpoint.
    id: ?[]const u8,

    /// A short string appended to the end of the OriginEndpoint URL.
    manifest_name: ?[]const u8,

    mss_package: ?MssPackage,

    /// Control whether origination of video is allowed for this OriginEndpoint. If
    /// set to ALLOW, the OriginEndpoint
    /// may by requested, pursuant to any other form of access control. If set to
    /// DENY, the OriginEndpoint may not be
    /// requested. This can be helpful for Live to VOD harvesting, or for
    /// temporarily disabling origination
    origination: ?Origination,

    /// Maximum duration (seconds) of content to retain for startover playback.
    /// If not specified, startover playback will be disabled for the
    /// OriginEndpoint.
    startover_window_seconds: ?i32,

    tags: ?[]const aws.map.StringMapEntry,

    /// Amount of delay (seconds) to enforce on the playback of live content.
    /// If not specified, there will be no time delay in effect for the
    /// OriginEndpoint.
    time_delay_seconds: ?i32,

    /// The URL of the packaged OriginEndpoint for consumption.
    url: ?[]const u8,

    /// A list of source IP CIDR blocks that will be allowed to access the
    /// OriginEndpoint.
    whitelist: ?[]const []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .authorization = "Authorization",
        .channel_id = "ChannelId",
        .cmaf_package = "CmafPackage",
        .created_at = "CreatedAt",
        .dash_package = "DashPackage",
        .description = "Description",
        .hls_package = "HlsPackage",
        .id = "Id",
        .manifest_name = "ManifestName",
        .mss_package = "MssPackage",
        .origination = "Origination",
        .startover_window_seconds = "StartoverWindowSeconds",
        .tags = "Tags",
        .time_delay_seconds = "TimeDelaySeconds",
        .url = "Url",
        .whitelist = "Whitelist",
    };
};
