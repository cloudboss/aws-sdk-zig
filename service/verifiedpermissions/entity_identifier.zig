/// Contains the identifier of an entity, including its ID and type.
///
/// This data type is used as a request parameter for
/// [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html) operation, and as a response parameter for the [CreatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicy.html), [GetPolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_GetPolicy.html), and [UpdatePolicy](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicy.html) operations.
///
/// Example: `{"entityId":"*string*","entityType":"*string*"}`
pub const EntityIdentifier = struct {
    /// The identifier of an entity.
    ///
    /// `"entityId":"*identifier*"`
    entity_id: []const u8,

    /// The type of an entity.
    ///
    /// Example: `"entityType":"*typeName*"`
    entity_type: []const u8,

    pub const json_field_names = .{
        .entity_id = "entityId",
        .entity_type = "entityType",
    };
};
