const SessionMetadataShape = @import("session_metadata_shape.zig").SessionMetadataShape;

/// Metadata for the evaluation, including session-specific ground truth data.
pub const EvaluationMetadata = union(enum) {
    /// A list of session metadata entries containing ground truth data and test
    /// scenario identifiers for specific sessions.
    session_metadata: ?[]const SessionMetadataShape,

    pub const json_field_names = .{
        .session_metadata = "sessionMetadata",
    };
};
