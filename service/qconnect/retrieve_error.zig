const RetrieveErrorCode = @import("retrieve_error_code.zig").RetrieveErrorCode;

/// An error returned for a single assistant association whose knowledge base
/// retrieval failed during a `Retrieve` operation. The overall operation still
/// succeeds and returns the results from the associations that were queried
/// successfully.
pub const RetrieveError = struct {
    /// The identifier of the assistant association whose knowledge base retrieval
    /// failed.
    association_id: []const u8,

    /// The error code that categorizes the retrieval failure for the assistant
    /// association.
    code: RetrieveErrorCode,

    /// A human-readable description of the retrieval failure for the assistant
    /// association.
    message: []const u8,

    pub const json_field_names = .{
        .association_id = "associationId",
        .code = "code",
        .message = "message",
    };
};
