const ReviewStatus = @import("review_status.zig").ReviewStatus;

/// Information about the result of a document review request.
pub const ReviewInformation = struct {
    /// The time that the reviewer took action on the document review request.
    reviewed_time: ?i64,

    /// The reviewer assigned to take action on the document review request.
    reviewer: ?[]const u8,

    /// The current status of the document review request.
    status: ?ReviewStatus,

    pub const json_field_names = .{
        .reviewed_time = "ReviewedTime",
        .reviewer = "Reviewer",
        .status = "Status",
    };
};
