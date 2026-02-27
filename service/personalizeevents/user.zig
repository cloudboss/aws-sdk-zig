/// Represents user metadata added to a Users dataset using the
/// `PutUsers` API. For more information see
/// [Importing users
/// individually](https://docs.aws.amazon.com/personalize/latest/dg/importing-users.html).
pub const User = struct {
    /// A string map of user-specific metadata. Each element in the map consists of
    /// a key-value pair.
    /// For example, `{"numberOfVideosWatched": "45"}`.
    ///
    /// The keys use camel case names that match the fields in the schema for the
    /// Users
    /// dataset. In the previous example, the `numberOfVideosWatched` matches the
    /// 'NUMBER_OF_VIDEOS_WATCHED' field defined in the Users schema. For
    /// categorical string data,
    /// to include multiple categories for a single user, separate each category
    /// with a pipe separator (`|`).
    /// For example, `\"Member|Frequent shopper\"`.
    properties: ?[]const u8,

    /// The ID associated with the user.
    user_id: []const u8,

    pub const json_field_names = .{
        .properties = "properties",
        .user_id = "userId",
    };
};
