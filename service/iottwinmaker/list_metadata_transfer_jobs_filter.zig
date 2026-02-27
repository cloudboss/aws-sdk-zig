const MetadataTransferJobState = @import("metadata_transfer_job_state.zig").MetadataTransferJobState;

/// The ListMetadataTransferJobs filter.
pub const ListMetadataTransferJobsFilter = union(enum) {
    /// The filter state.
    state: ?MetadataTransferJobState,
    /// The workspace Id.
    workspace_id: ?[]const u8,

    pub const json_field_names = .{
        .state = "state",
        .workspace_id = "workspaceId",
    };
};
