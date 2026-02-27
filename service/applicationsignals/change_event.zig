const aws = @import("aws");

const ChangeEventType = @import("change_event_type.zig").ChangeEventType;

/// A structure that contains information about a change event that occurred for
/// a service, such as a deployment or configuration change.
pub const ChangeEvent = struct {
    /// The Amazon Web Services account ID where this change event occurred.
    account_id: []const u8,

    /// The type of change event that occurred, such as `DEPLOYMENT`.
    change_event_type: ChangeEventType,

    /// The entity (service or resource) that was affected by this change event,
    /// including its key attributes.
    ///
    /// This is a string-to-string map. It can include the following fields.
    ///
    /// * `Type` designates the type of object this is.
    /// * `ResourceType` specifies the type of the resource. This field is used only
    ///   when the value of the `Type` field is `Resource` or `AWS::Resource`.
    /// * `Name` specifies the name of the object. This is used only if the value of
    ///   the `Type` field is `Service`, `RemoteService`, or `AWS::Service`.
    /// * `Identifier` identifies the resource objects of this resource. This is
    ///   used only if the value of the `Type` field is `Resource` or
    ///   `AWS::Resource`.
    /// * `Environment` specifies the location where this object is hosted, or what
    ///   it belongs to.
    /// * `AwsAccountId` specifies the account where this object is in.
    ///
    /// Below is an example of a service.
    ///
    /// `{ "Type": "Service", "Name": "visits-service", "Environment":
    /// "petclinic-test" }`
    ///
    /// Below is an example of a resource.
    ///
    /// `{ "Type": "AWS::Resource", "ResourceType": "AWS::DynamoDB::Table",
    /// "Identifier": "Customers" }`
    entity: []const aws.map.StringMapEntry,

    /// A unique identifier for this change event. For CloudTrail-based events, this
    /// is the CloudTrail event id. For other events, this will be `Unknown`.
    event_id: []const u8,

    /// The name or description of this change event.
    event_name: ?[]const u8,

    /// The Amazon Web Services region where this change event occurred.
    region: []const u8,

    /// The timestamp when this change event occurred. When used in a raw HTTP Query
    /// API, it is formatted as epoch time in seconds.
    timestamp: i64,

    /// The name of the user who initiated this change event, if available.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .change_event_type = "ChangeEventType",
        .entity = "Entity",
        .event_id = "EventId",
        .event_name = "EventName",
        .region = "Region",
        .timestamp = "Timestamp",
        .user_name = "UserName",
    };
};
