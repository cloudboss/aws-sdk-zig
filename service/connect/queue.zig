const aws = @import("aws");

const OutboundCallerConfig = @import("outbound_caller_config.zig").OutboundCallerConfig;
const OutboundEmailConfig = @import("outbound_email_config.zig").OutboundEmailConfig;
const QueueStatus = @import("queue_status.zig").QueueStatus;

/// Contains information about a queue.
pub const Queue = struct {
    /// The description of the queue.
    description: ?[]const u8 = null,

    /// The identifier for the hours of operation.
    hours_of_operation_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The maximum number of contacts that can be in the queue before it is
    /// considered full.
    max_contacts: ?i32 = null,

    /// The name of the queue.
    name: ?[]const u8 = null,

    /// The outbound caller ID name, number, and outbound whisper flow.
    outbound_caller_config: ?OutboundCallerConfig = null,

    /// The outbound email address ID for a specified queue.
    outbound_email_config: ?OutboundEmailConfig = null,

    /// The Amazon Resource Name (ARN) for the queue.
    queue_arn: ?[]const u8 = null,

    /// The identifier for the queue.
    queue_id: ?[]const u8 = null,

    /// The status of the queue.
    status: ?QueueStatus = null,

    /// The tags used to organize, track, or control access for this resource. For
    /// example, { "Tags": {"key1":"value1", "key2":"value2"} }.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .hours_of_operation_id = "HoursOfOperationId",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .max_contacts = "MaxContacts",
        .name = "Name",
        .outbound_caller_config = "OutboundCallerConfig",
        .outbound_email_config = "OutboundEmailConfig",
        .queue_arn = "QueueArn",
        .queue_id = "QueueId",
        .status = "Status",
        .tags = "Tags",
    };
};
