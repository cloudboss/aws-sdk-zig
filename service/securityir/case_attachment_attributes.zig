const CaseAttachmentStatus = @import("case_attachment_status.zig").CaseAttachmentStatus;

pub const CaseAttachmentAttributes = struct {
    attachment_id: []const u8,

    attachment_status: CaseAttachmentStatus,

    created_date: i64,

    creator: []const u8,

    file_name: []const u8,

    pub const json_field_names = .{
        .attachment_id = "attachmentId",
        .attachment_status = "attachmentStatus",
        .created_date = "createdDate",
        .creator = "creator",
        .file_name = "fileName",
    };
};
