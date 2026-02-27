const aws = @import("aws");

const EventsBatch = @import("events_batch.zig").EventsBatch;

/// Specifies a batch of events to process.
pub const EventsRequest = struct {
    /// The batch of events to process. For each item in a batch, the endpoint ID
    /// acts as a key that has an EventsBatch object as its value.
    batch_item: []const aws.map.MapEntry(EventsBatch),

    pub const json_field_names = .{
        .batch_item = "BatchItem",
    };
};
