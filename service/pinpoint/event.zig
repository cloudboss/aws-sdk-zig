const aws = @import("aws");

const Session = @import("session.zig").Session;

/// Specifies information about an event that reports data to Amazon Pinpoint.
pub const Event = struct {
    /// The package name of the app that's recording the event.
    app_package_name: ?[]const u8 = null,

    /// The title of the app that's recording the event.
    app_title: ?[]const u8 = null,

    /// The version number of the app that's recording the event.
    app_version_code: ?[]const u8 = null,

    /// One or more custom attributes that are associated with the event.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The version of the SDK that's running on the client device.
    client_sdk_version: ?[]const u8 = null,

    /// The name of the event.
    event_type: []const u8,

    /// One or more custom metrics that are associated with the event.
    metrics: ?[]const aws.map.MapEntry(f64) = null,

    /// The name of the SDK that's being used to record the event.
    sdk_name: ?[]const u8 = null,

    /// Information about the session in which the event occurred.
    session: ?Session = null,

    /// The date and time, in ISO 8601 format, when the event occurred.
    timestamp: []const u8,

    pub const json_field_names = .{
        .app_package_name = "AppPackageName",
        .app_title = "AppTitle",
        .app_version_code = "AppVersionCode",
        .attributes = "Attributes",
        .client_sdk_version = "ClientSdkVersion",
        .event_type = "EventType",
        .metrics = "Metrics",
        .sdk_name = "SdkName",
        .session = "Session",
        .timestamp = "Timestamp",
    };
};
