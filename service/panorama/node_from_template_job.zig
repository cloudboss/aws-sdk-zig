const NodeFromTemplateJobStatus = @import("node_from_template_job_status.zig").NodeFromTemplateJobStatus;
const TemplateType = @import("template_type.zig").TemplateType;

/// A job to create a camera stream node.
pub const NodeFromTemplateJob = struct {
    /// When the job was created.
    created_time: ?i64 = null,

    /// The job's ID.
    job_id: ?[]const u8 = null,

    /// The node's name.
    node_name: ?[]const u8 = null,

    /// The job's status.
    status: ?NodeFromTemplateJobStatus = null,

    /// The job's status message.
    status_message: ?[]const u8 = null,

    /// The job's template type.
    template_type: ?TemplateType = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .job_id = "JobId",
        .node_name = "NodeName",
        .status = "Status",
        .status_message = "StatusMessage",
        .template_type = "TemplateType",
    };
};
