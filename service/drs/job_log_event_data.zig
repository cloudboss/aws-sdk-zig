const ConversionProperties = @import("conversion_properties.zig").ConversionProperties;
const EventResourceData = @import("event_resource_data.zig").EventResourceData;

/// Metadata associated with a Job log.
pub const JobLogEventData = struct {
    /// Properties of a conversion job
    conversion_properties: ?ConversionProperties,

    /// The ID of a conversion server.
    conversion_server_id: ?[]const u8,

    /// Properties of resource related to a job event.
    event_resource_data: ?EventResourceData,

    /// A string representing a job error.
    raw_error: ?[]const u8,

    /// The ID of a Source Server.
    source_server_id: ?[]const u8,

    /// The ID of a Recovery Instance.
    target_instance_id: ?[]const u8,

    pub const json_field_names = .{
        .conversion_properties = "conversionProperties",
        .conversion_server_id = "conversionServerID",
        .event_resource_data = "eventResourceData",
        .raw_error = "rawError",
        .source_server_id = "sourceServerID",
        .target_instance_id = "targetInstanceID",
    };
};
