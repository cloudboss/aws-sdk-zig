const Citation = @import("citation.zig").Citation;
const ReviewType = @import("review_type.zig").ReviewType;
const QueryStatus = @import("query_status.zig").QueryStatus;
const QueryStatusMessage = @import("query_status_message.zig").QueryStatusMessage;
const ResponseVersion = @import("response_version.zig").ResponseVersion;

/// Summary information about a single query within a compliance inquiry.
pub const QuerySummary = struct {
    /// Supporting citations for the response.
    citations: ?[]const Citation = null,

    /// Timestamp when the query was created.
    created_at: i64,

    /// The actual query text.
    query: []const u8,

    /// Sequential identifier of the query within the inquiry.
    query_identifier: i32,

    /// Generated response to the query.
    response: ?[]const u8 = null,

    /// Type of review for the response.
    review_type: ?ReviewType = null,

    /// Current processing status of the query.
    status: QueryStatus,

    /// Descriptive status message.
    status_message: QueryStatusMessage,

    /// Ordered list of response version history entries, oldest first.
    updated_response_versions: ?[]const ResponseVersion = null,

    pub const json_field_names = .{
        .citations = "citations",
        .created_at = "createdAt",
        .query = "query",
        .query_identifier = "queryIdentifier",
        .response = "response",
        .review_type = "reviewType",
        .status = "status",
        .status_message = "statusMessage",
        .updated_response_versions = "updatedResponseVersions",
    };
};
