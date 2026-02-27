const aws = @import("aws");

/// Returns information about a specific comment.
pub const Comment = struct {
    /// The Amazon Resource Name (ARN) of the person who posted the comment.
    author_arn: ?[]const u8,

    /// The emoji reactions to a comment, if any, submitted by the user whose
    /// credentials are associated with the call to the API.
    caller_reactions: ?[]const []const u8,

    /// A unique, client-generated idempotency token that, when provided in a
    /// request, ensures
    /// the request cannot be repeated with a changed parameter. If a request is
    /// received with
    /// the same parameters and a token is included, the request returns information
    /// about the
    /// initial request that used that token.
    client_request_token: ?[]const u8,

    /// The system-generated comment ID.
    comment_id: ?[]const u8,

    /// The content of the comment.
    content: ?[]const u8,

    /// The date and time the comment was created, in timestamp format.
    creation_date: ?i64,

    /// A Boolean value indicating whether the comment has been deleted.
    deleted: bool = false,

    /// The ID of the comment for which this comment is a reply, if any.
    in_reply_to: ?[]const u8,

    /// The date and time the comment was most recently modified, in timestamp
    /// format.
    last_modified_date: ?i64,

    /// A string to integer map that represents the number of individual users who
    /// have responded to a comment with the specified reactions.
    reaction_counts: ?[]const aws.map.MapEntry(i32),

    pub const json_field_names = .{
        .author_arn = "authorArn",
        .caller_reactions = "callerReactions",
        .client_request_token = "clientRequestToken",
        .comment_id = "commentId",
        .content = "content",
        .creation_date = "creationDate",
        .deleted = "deleted",
        .in_reply_to = "inReplyTo",
        .last_modified_date = "lastModifiedDate",
        .reaction_counts = "reactionCounts",
    };
};
