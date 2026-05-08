const aws = @import("aws");

const GroundTruthSource = @import("ground_truth_source.zig").GroundTruthSource;

/// Metadata for a specific session in a batch evaluation, including ground
/// truth data and test scenario identifiers.
pub const SessionMetadataShape = struct {
    /// The ground truth data for this session, including expected responses and
    /// assertions.
    ground_truth: ?GroundTruthSource = null,

    /// Additional key-value metadata associated with this session.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The unique identifier of the session this metadata applies to.
    session_id: []const u8,

    /// An optional test scenario identifier for categorizing and tracking
    /// evaluation results.
    test_scenario_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ground_truth = "groundTruth",
        .metadata = "metadata",
        .session_id = "sessionId",
        .test_scenario_id = "testScenarioId",
    };
};
