const aws = @import("aws");

/// Specifies data for one or more attributes that describe the user who's
/// associated with an endpoint.
pub const EndpointUser = struct {
    /// One or more custom attributes that describe the user by associating a name
    /// with an array of values. For example, the value of an attribute named
    /// Interests might be: ["Science", "Music", "Travel"]. You can use these
    /// attributes as filter criteria when you create segments. Attribute names are
    /// case sensitive.
    ///
    /// An attribute name can contain up to 50 characters. An attribute value can
    /// contain up to 100 characters. When you define the name of a custom
    /// attribute, avoid using the following characters: number sign (#), colon (:),
    /// question mark (?), backslash (\), and slash (/). The Amazon Pinpoint console
    /// can't display attribute names that contain these characters. This
    /// restriction doesn't apply to attribute values.
    user_attributes: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The unique identifier for the user.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .user_attributes = "UserAttributes",
        .user_id = "UserId",
    };
};
