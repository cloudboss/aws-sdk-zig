const FieldContentType = @import("field_content_type.zig").FieldContentType;

/// Represents a field in a ProfileObjectType.
pub const ObjectTypeField = struct {
    /// The content type of the field. Used for determining equality when searching.
    content_type: ?FieldContentType,

    /// A field of a ProfileObject. For example: _source.FirstName, where “_source”
    /// is a
    /// ProfileObjectType of a Zendesk user and “FirstName” is a field in that
    /// ObjectType.
    source: ?[]const u8,

    /// The location of the data in the standard ProfileObject model. For example:
    /// _profile.Address.PostalCode.
    target: ?[]const u8,

    pub const json_field_names = .{
        .content_type = "ContentType",
        .source = "Source",
        .target = "Target",
    };
};
