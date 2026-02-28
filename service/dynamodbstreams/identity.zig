/// Contains details about the type of identity that made the request.
pub const Identity = struct {
    /// A unique identifier for the entity that made the call. For Time To Live, the
    /// principalId is "dynamodb.amazonaws.com".
    principal_id: ?[]const u8,

    /// The type of the identity. For Time To Live, the type is "Service".
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .principal_id = "PrincipalId",
        .@"type" = "Type",
    };
};
