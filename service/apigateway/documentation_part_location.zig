const DocumentationPartType = @import("documentation_part_type.zig").DocumentationPartType;

/// Specifies the target API entity to which the documentation applies.
pub const DocumentationPartLocation = struct {
    /// The HTTP verb of a method. It is a valid field for the API entity types of
    /// `METHOD`, `PATH_PARAMETER`, `QUERY_PARAMETER`, `REQUEST_HEADER`,
    /// `REQUEST_BODY`, `RESPONSE`, `RESPONSE_HEADER`, and `RESPONSE_BODY`. The
    /// default value is `*` for any method. When an applicable child entity
    /// inherits the content of an entity of the same type with more general
    /// specifications of the other `location` attributes, the child entity's
    /// `method` attribute must match that of the parent entity exactly.
    method: ?[]const u8 = null,

    /// The name of the targeted API entity. It is a valid and required field for
    /// the API entity types of `AUTHORIZER`, `MODEL`, `PATH_PARAMETER`,
    /// `QUERY_PARAMETER`, `REQUEST_HEADER`, `REQUEST_BODY` and `RESPONSE_HEADER`.
    /// It is an invalid field for any other entity type.
    name: ?[]const u8 = null,

    /// The URL path of the target. It is a valid field for the API entity types of
    /// `RESOURCE`, `METHOD`, `PATH_PARAMETER`, `QUERY_PARAMETER`, `REQUEST_HEADER`,
    /// `REQUEST_BODY`, `RESPONSE`, `RESPONSE_HEADER`, and `RESPONSE_BODY`. The
    /// default value is `/` for the root resource. When an applicable child entity
    /// inherits the content of another entity of the same type with more general
    /// specifications of the other `location` attributes, the child entity's `path`
    /// attribute must match that of the parent entity as a prefix.
    path: ?[]const u8 = null,

    /// The HTTP status code of a response. It is a valid field for the API entity
    /// types of `RESPONSE`, `RESPONSE_HEADER`, and `RESPONSE_BODY`. The default
    /// value is `*` for any status code. When an applicable child entity inherits
    /// the content of an entity of the same type with more general specifications
    /// of the other `location` attributes, the child entity's `statusCode`
    /// attribute must match that of the parent entity exactly.
    status_code: ?[]const u8 = null,

    /// The type of API entity to which the documentation content applies. Valid
    /// values are `API`, `AUTHORIZER`, `MODEL`, `RESOURCE`, `METHOD`,
    /// `PATH_PARAMETER`, `QUERY_PARAMETER`, `REQUEST_HEADER`, `REQUEST_BODY`,
    /// `RESPONSE`, `RESPONSE_HEADER`, and `RESPONSE_BODY`. Content inheritance does
    /// not apply to any entity of the `API`, `AUTHORIZER`, `METHOD`, `MODEL`,
    /// `REQUEST_BODY`, or `RESOURCE` type.
    @"type": DocumentationPartType,

    pub const json_field_names = .{
        .method = "method",
        .name = "name",
        .path = "path",
        .status_code = "statusCode",
        .@"type" = "type",
    };
};
