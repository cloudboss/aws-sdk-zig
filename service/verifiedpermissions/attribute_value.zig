const aws = @import("aws");

const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// The value of an attribute.
///
/// Contains information about the runtime context for a request for which an
/// authorization decision is made.
///
/// This data type is used as a member of the
/// [ContextDefinition](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ContextDefinition.html) structure which is used as a request parameter for the [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html), [BatchIsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorized.html), and [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) operations.
pub const AttributeValue = union(enum) {
    /// An attribute value of
    /// [Boolean](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-bool) type.
    ///
    /// Example: `{"boolean": true}`
    boolean: ?bool,
    /// An attribute value of
    /// [datetime](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-datetime) type.
    ///
    /// Example: `{"datetime": "2024-10-15T11:35:00Z"}`
    datetime: ?[]const u8,
    /// An attribute value of
    /// [decimal](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-decimal) type.
    ///
    /// Example: `{"decimal": "1.1"}`
    decimal: ?[]const u8,
    /// An attribute value of
    /// [duration](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-duration) type.
    ///
    /// Example: `{"duration": "1h30m"}`
    duration: ?[]const u8,
    /// An attribute value of type
    /// [EntityIdentifier](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_EntityIdentifier.html).
    ///
    /// Example: `{"entityIdentifier": { "entityId": "alice", "entityType": "User"}
    /// }`
    entity_identifier: ?EntityIdentifier,
    /// An attribute value of
    /// [ipaddr](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-ipaddr) type.
    ///
    /// Example: `{"ip": "192.168.1.100"}`
    ipaddr: ?[]const u8,
    /// An attribute value of
    /// [Long](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-long) type.
    ///
    /// Example: `{"long": 0}`
    long: ?i64,
    /// An attribute value of
    /// [Record](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-record) type.
    ///
    /// Example: `{"record": { "keyName": {} } }`
    record: ?[]const aws.map.MapEntry(AttributeValue),
    /// An attribute value of
    /// [Set](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-set) type.
    ///
    /// Example: `{"set": [ {} ] }`
    set: ?[]const AttributeValue,
    /// An attribute value of
    /// [String](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-string) type.
    ///
    /// Example: `{"string": "abc"}`
    string: ?[]const u8,

    pub const json_field_names = .{
        .boolean = "boolean",
        .datetime = "datetime",
        .decimal = "decimal",
        .duration = "duration",
        .entity_identifier = "entityIdentifier",
        .ipaddr = "ipaddr",
        .long = "long",
        .record = "record",
        .set = "set",
        .string = "string",
    };
};
