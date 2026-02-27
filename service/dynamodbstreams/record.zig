const StreamRecord = @import("stream_record.zig").StreamRecord;
const OperationType = @import("operation_type.zig").OperationType;
const Identity = @import("identity.zig").Identity;

/// A description of a unique event within a stream.
pub const Record = struct {
    /// The region in which the `GetRecords` request was received.
    aws_region: ?[]const u8,

    /// The main body of the stream record, containing all of the DynamoDB-specific
    /// fields.
    dynamodb: ?StreamRecord,

    /// A globally unique identifier for the event that was recorded in this stream
    /// record.
    event_id: ?[]const u8,

    /// The type of data modification that was performed on the DynamoDB table:
    ///
    /// * `INSERT` - a new item was added to the table.
    ///
    /// * `MODIFY` - one or more of an existing item's attributes were modified.
    ///
    /// * `REMOVE` - the item was deleted from the table
    event_name: ?OperationType,

    /// The Amazon Web Services service from which the stream record originated. For
    /// DynamoDB Streams, this is `aws:dynamodb`.
    event_source: ?[]const u8,

    /// The version number of the stream record format. This number is updated
    /// whenever the structure of `Record` is modified.
    ///
    /// Client applications must not assume that `eventVersion` will remain at a
    /// particular
    /// value, as this number is subject to change at any time. In general,
    /// `eventVersion` will
    /// only increase as the low-level DynamoDB Streams API evolves.
    event_version: ?[]const u8,

    /// Items that are deleted by the Time to Live process after expiration have the
    /// following fields:
    ///
    /// * Records[].userIdentity.type
    ///
    /// "Service"
    ///
    /// * Records[].userIdentity.principalId
    ///
    /// "dynamodb.amazonaws.com"
    user_identity: ?Identity,

    pub const json_field_names = .{
        .aws_region = "awsRegion",
        .dynamodb = "dynamodb",
        .event_id = "eventID",
        .event_name = "eventName",
        .event_source = "eventSource",
        .event_version = "eventVersion",
        .user_identity = "userIdentity",
    };
};
