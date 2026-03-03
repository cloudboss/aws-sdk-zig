const OutputDetail = @import("output_detail.zig").OutputDetail;

/// Contains details about the output groups specified in the job settings.
pub const OutputGroupDetail = struct {
    /// Details about the output
    output_details: ?[]const OutputDetail = null,

    pub const json_field_names = .{
        .output_details = "OutputDetails",
    };
};
