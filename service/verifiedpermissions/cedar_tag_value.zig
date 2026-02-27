const aws = @import("aws");

const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// The value of an entity's Cedar tag.
///
/// This data type is used as a member of the
/// [EntityItem](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_EntityItem.html) structure that forms the body of the `Entities` request parameter for the [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html), [BatchIsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorized.html), [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html), and [BatchIsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_BatchIsAuthorizedWithToken.html) operations.
pub const CedarTagValue = union(enum) {
    /// A Cedar tag value of
    /// [Boolean](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-bool) type.
    ///
    /// Example: `{"boolean": false}`
    boolean: ?bool,
    /// A Cedar tag value of
    /// [datetime](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-datetime) type.
    ///
    /// Example: `{"datetime": "2025-11-04T11:35:00.000+0100"}`
    datetime: ?[]const u8,
    /// A Cedar tag value of
    /// [decimal](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-decimal) type.
    ///
    /// Example: `{"decimal": "-2.0"}`
    decimal: ?[]const u8,
    /// A Cedar tag value of
    /// [duration](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-duration) type.
    ///
    /// Example: `{"duration": "-1d12h"}`
    duration: ?[]const u8,
    /// A Cedar tag value of type
    /// [EntityIdentifier](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_EntityIdentifier.html).
    ///
    /// Example: `{"entityIdentifier": { "entityId": "alice", "entityType": "User"}
    /// }`
    entity_identifier: ?EntityIdentifier,
    /// A Cedar tag value of
    /// [ipaddr](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-ipaddr) type.
    ///
    /// Example: `{"ip": "10.50.0.0/24"}`
    ipaddr: ?[]const u8,
    /// A Cedar tag value of
    /// [Long](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-long) type.
    ///
    /// Example: `{"long": 0}`
    long: ?i64,
    /// A Cedar tag value of
    /// [Record](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-record) type.
    ///
    /// Example: `{"record": { "keyName": {} } }`
    record: ?[]const aws.map.MapEntry(CedarTagValue),
    /// A Cedar tag value of
    /// [Set](https://docs.cedarpolicy.com/policies/syntax-datatypes.html#datatype-set) type.
    ///
    /// Example: `{"set": [ { "string": "abc" } ] }`
    set: ?[]const CedarTagValue,
    /// A Cedar tag value of
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
