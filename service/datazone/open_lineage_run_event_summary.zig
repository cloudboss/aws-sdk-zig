const OpenLineageRunState = @import("open_lineage_run_state.zig").OpenLineageRunState;
const NameIdentifier = @import("name_identifier.zig").NameIdentifier;

/// The open lineage run event summary.
pub const OpenLineageRunEventSummary = struct {
    /// The event type of the open lineage run event summary.
    event_type: ?OpenLineageRunState = null,

    /// The inputs of the open lineage run event summary.
    inputs: ?[]const NameIdentifier = null,

    /// The job of the open lineage run event summary.
    job: ?NameIdentifier = null,

    /// The outputs of the open lineage run event summary.
    outputs: ?[]const NameIdentifier = null,

    /// The runID of the open lineage run event summary.
    run_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_type = "eventType",
        .inputs = "inputs",
        .job = "job",
        .outputs = "outputs",
        .run_id = "runId",
    };
};
