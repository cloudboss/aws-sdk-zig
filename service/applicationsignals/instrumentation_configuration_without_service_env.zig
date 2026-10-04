const aws = @import("aws");

const CaptureConfiguration = @import("capture_configuration.zig").CaptureConfiguration;
const InstrumentationType = @import("instrumentation_type.zig").InstrumentationType;
const Location = @import("location.zig").Location;
const DynamicInstrumentationSignalType = @import("dynamic_instrumentation_signal_type.zig").DynamicInstrumentationSignalType;

/// An instrumentation configuration that omits service and environment because
/// they are provided at a higher level, such as in a list response.
pub const InstrumentationConfigurationWithoutServiceEnv = struct {
    /// ARN for the instrumentation configuration
    arn: []const u8,

    /// Client-side filters that determine which instances apply this
    /// instrumentation.
    attribute_filters: ?[]const []const aws.map.StringMapEntry = null,

    /// The capture settings for this instrumentation configuration.
    capture_configuration: CaptureConfiguration,

    /// The timestamp when this instrumentation configuration was created.
    created_at: i64,

    /// An optional short description of the instrumentation configuration.
    description: ?[]const u8 = null,

    /// The timestamp when this configuration expires.
    expires_at: ?i64 = null,

    /// The type of instrumentation for this configuration.
    instrumentation_type: InstrumentationType,

    /// The location where this instrumentation is applied.
    location: Location,

    /// The stable hash derived from the location that identifies this
    /// instrumentation point.
    location_hash: []const u8,

    /// The telemetry signal type for this instrumentation configuration.
    signal_type: DynamicInstrumentationSignalType,

    pub const json_field_names = .{
        .arn = "ARN",
        .attribute_filters = "AttributeFilters",
        .capture_configuration = "CaptureConfiguration",
        .created_at = "CreatedAt",
        .description = "Description",
        .expires_at = "ExpiresAt",
        .instrumentation_type = "InstrumentationType",
        .location = "Location",
        .location_hash = "LocationHash",
        .signal_type = "SignalType",
    };
};
