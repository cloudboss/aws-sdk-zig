/// Contains information about the reason that the retrieval of a recommendation
/// for a finding failed.
pub const RecommendationError = struct {
    /// The error code for a failed retrieval of a recommendation for a finding.
    code: []const u8,

    /// The error message for a failed retrieval of a recommendation for a finding.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
