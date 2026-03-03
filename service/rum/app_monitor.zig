const aws = @import("aws");

const AppMonitorConfiguration = @import("app_monitor_configuration.zig").AppMonitorConfiguration;
const CustomEvents = @import("custom_events.zig").CustomEvents;
const DataStorage = @import("data_storage.zig").DataStorage;
const DeobfuscationConfiguration = @import("deobfuscation_configuration.zig").DeobfuscationConfiguration;
const AppMonitorPlatform = @import("app_monitor_platform.zig").AppMonitorPlatform;
const StateEnum = @import("state_enum.zig").StateEnum;

/// A RUM app monitor collects telemetry data from your application and sends
/// that data to RUM. The data includes performance and reliability information
/// such as page load time, client-side errors, and user behavior.
pub const AppMonitor = struct {
    /// A structure that contains much of the configuration data for the app
    /// monitor.
    app_monitor_configuration: ?AppMonitorConfiguration = null,

    /// The date and time that this app monitor was created.
    created: ?[]const u8 = null,

    /// Specifies whether this app monitor allows the web client to define and send
    /// custom events.
    ///
    /// For more information about custom events, see [Send custom
    /// events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-RUM-custom-events.html).
    custom_events: ?CustomEvents = null,

    /// A structure that contains information about whether this app monitor stores
    /// a copy of the telemetry data that RUM collects using CloudWatch Logs.
    data_storage: ?DataStorage = null,

    /// A structure that contains the configuration for how an app monitor can
    /// deobfuscate stack traces.
    deobfuscation_configuration: ?DeobfuscationConfiguration = null,

    /// The top-level internet domain name for which your application has
    /// administrative authority.
    domain: ?[]const u8 = null,

    /// List the domain names for which your application has administrative
    /// authority.
    domain_list: ?[]const []const u8 = null,

    /// The unique ID of this app monitor.
    id: ?[]const u8 = null,

    /// The date and time of the most recent changes to this app monitor's
    /// configuration.
    last_modified: ?[]const u8 = null,

    /// The name of the app monitor.
    name: ?[]const u8 = null,

    /// The platform type for this app monitor. Valid values are `Web` for web
    /// applications , `Android` for Android applications, and `iOS` for IOS
    /// applications.
    platform: ?AppMonitorPlatform = null,

    /// The current state of the app monitor.
    state: ?StateEnum = null,

    /// The list of tag keys and values associated with this app monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .app_monitor_configuration = "AppMonitorConfiguration",
        .created = "Created",
        .custom_events = "CustomEvents",
        .data_storage = "DataStorage",
        .deobfuscation_configuration = "DeobfuscationConfiguration",
        .domain = "Domain",
        .domain_list = "DomainList",
        .id = "Id",
        .last_modified = "LastModified",
        .name = "Name",
        .platform = "Platform",
        .state = "State",
        .tags = "Tags",
    };
};
