const EntityItem = @import("entity_item.zig").EntityItem;

/// Contains the list of entities to be considered during an authorization
/// request. This includes all principals, resources, and actions required to
/// successfully evaluate the request.
///
/// This data type is used as a field in the response parameter for the
/// [IsAuthorized](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorized.html) and [IsAuthorizedWithToken](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_IsAuthorizedWithToken.html) operations.
pub const EntitiesDefinition = union(enum) {
    /// A Cedar JSON string representation of the entities needed to successfully
    /// evaluate an authorization request.
    ///
    /// Example: `{"cedarJson":
    /// "[{\"uid\":{\"type\":\"Photo\",\"id\":\"VacationPhoto94.jpg\"},\"attrs\":{\"accessLevel\":\"public\"},\"parents\":[]}]"}`
    cedar_json: ?[]const u8,
    /// An array of entities that are needed to successfully evaluate an
    /// authorization request. Each entity in this array must include an identifier
    /// for the entity, the attributes of the entity, and a list of any parent
    /// entities.
    ///
    /// If you include multiple entities with the same `identifier`, only the last
    /// one is processed in the request.
    entity_list: ?[]const EntityItem,

    pub const json_field_names = .{
        .cedar_json = "cedarJson",
        .entity_list = "entityList",
    };
};
