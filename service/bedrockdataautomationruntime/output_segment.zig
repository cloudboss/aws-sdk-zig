const CustomOutputStatus = @import("custom_output_status.zig").CustomOutputStatus;

/// Results for an output segment
pub const OutputSegment = struct {
    /// Custom output response
    custom_output: ?[]const u8,

    /// Status of blueprint match
    custom_output_status: ?CustomOutputStatus,

    /// Standard output response
    standard_output: ?[]const u8,

    pub const json_field_names = .{
        .custom_output = "customOutput",
        .custom_output_status = "customOutputStatus",
        .standard_output = "standardOutput",
    };
};
