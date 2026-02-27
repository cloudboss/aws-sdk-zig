/// Details about an error returned for a BatchGetIncidentFindings
/// operation.
pub const BatchGetIncidentFindingsError = struct {
    /// The code associated with an error that was returned for a
    /// `BatchGetIncidentFindings` operation.
    code: []const u8,

    /// The ID of a specified finding for which an error was returned for a
    /// `BatchGetIncidentFindings` operation.
    finding_id: []const u8,

    /// The description for an error that was returned for a
    /// `BatchGetIncidentFindings`
    /// operation.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .finding_id = "findingId",
        .message = "message",
    };
};
