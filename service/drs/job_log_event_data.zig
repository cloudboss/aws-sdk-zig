const ConversionProperties = @import("conversion_properties.zig").ConversionProperties;
const EventResourceData = @import("event_resource_data.zig").EventResourceData;

/// Metadata associated with a Job log.
pub const JobLogEventData = struct {
    /// Retries for this operation.
    attempt_count: i64 = 0,

    /// Properties of a conversion job
    conversion_properties: ?ConversionProperties = null,

    /// The ID of a conversion server.
    conversion_server_id: ?[]const u8 = null,

    /// Properties of resource related to a job event.
    event_resource_data: ?EventResourceData = null,

    /// The maximum number of retries that will be attempted if this operation
    /// failed.
    max_attempts_count: i64 = 0,

    /// A string representing a job error.
    raw_error: ?[]const u8 = null,

    /// The ID of a Source Server.
    source_server_id: ?[]const u8 = null,

    /// The ID of a Recovery Instance.
    target_instance_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .attempt_count = "attemptCount",
        .conversion_properties = "conversionProperties",
        .conversion_server_id = "conversionServerID",
        .event_resource_data = "eventResourceData",
        .max_attempts_count = "maxAttemptsCount",
        .raw_error = "rawError",
        .source_server_id = "sourceServerID",
        .target_instance_id = "targetInstanceID",
    };
};
