const aws = @import("aws");

/// Represents a matched event.
pub const MetricFilterMatchRecord = struct {
    /// The raw event data.
    event_message: ?[]const u8 = null,

    /// The event number.
    event_number: i64 = 0,

    /// The values extracted from the event data by the filter.
    extracted_values: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .event_message = "eventMessage",
        .event_number = "eventNumber",
        .extracted_values = "extractedValues",
    };
};
