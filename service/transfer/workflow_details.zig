const WorkflowDetail = @import("workflow_detail.zig").WorkflowDetail;

/// Container for the `WorkflowDetail` data type. It is used by actions that
/// trigger a workflow to begin execution.
pub const WorkflowDetails = struct {
    /// A trigger that starts a workflow if a file is only partially uploaded. You
    /// can attach a workflow to a server that executes whenever there is a partial
    /// upload.
    ///
    /// A *partial upload* occurs when a file is open when the session disconnects.
    ///
    /// `OnPartialUpload` can contain a maximum of one `WorkflowDetail` object.
    on_partial_upload: ?[]const WorkflowDetail,

    /// A trigger that starts a workflow: the workflow begins to execute after a
    /// file is uploaded.
    ///
    /// To remove an associated workflow from a server, you can provide an empty
    /// `OnUpload` object, as in the following example.
    ///
    /// `aws transfer update-server --server-id s-01234567890abcdef
    /// --workflow-details '{"OnUpload":[]}'`
    ///
    /// `OnUpload` can contain a maximum of one `WorkflowDetail` object.
    on_upload: ?[]const WorkflowDetail,

    pub const json_field_names = .{
        .on_partial_upload = "OnPartialUpload",
        .on_upload = "OnUpload",
    };
};
