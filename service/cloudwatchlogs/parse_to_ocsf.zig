const EventSource = @import("event_source.zig").EventSource;
const OCSFVersion = @import("ocsf_version.zig").OCSFVersion;

/// This processor converts logs into [Open Cybersecurity Schema
/// Framework (OCSF)](https://ocsf.io) events.
///
/// For more information about this processor including examples, see
/// [parseToOCSF](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseToOCSF) in the *CloudWatch Logs User Guide*.
pub const ParseToOCSF = struct {
    /// Specify the service or process that produces the log events that will be
    /// converted with
    /// this processor.
    event_source: EventSource,

    /// The version of the OCSF mapping to use for parsing log data.
    mapping_version: ?[]const u8 = null,

    /// Specify which version of the OCSF schema to use for the transformed log
    /// events.
    ocsf_version: OCSFVersion,

    /// The path to the field in the log event that you want to parse. If you omit
    /// this value, the
    /// whole log message is parsed.
    source: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_source = "eventSource",
        .mapping_version = "mappingVersion",
        .ocsf_version = "ocsfVersion",
        .source = "source",
    };
};
