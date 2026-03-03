/// Represents the timeline of the cluster's lifecycle.
pub const ClusterTimeline = struct {
    /// The creation date and time of the cluster.
    creation_date_time: ?i64 = null,

    /// The date and time when the cluster was terminated.
    end_date_time: ?i64 = null,

    /// The date and time when the cluster was ready to run steps.
    ready_date_time: ?i64 = null,

    pub const json_field_names = .{
        .creation_date_time = "CreationDateTime",
        .end_date_time = "EndDateTime",
        .ready_date_time = "ReadyDateTime",
    };
};
