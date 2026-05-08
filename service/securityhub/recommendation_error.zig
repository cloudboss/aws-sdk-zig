/// Contains information about the reason that the retrieval of a recommended
/// policy for a finding failed.
pub const RecommendationError = struct {
    /// The error code for a failed retrieval of a recommended policy for a finding.
    code: ?[]const u8 = null,

    /// The error message for a failed retrieval of a recommended policy for a
    /// finding.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
