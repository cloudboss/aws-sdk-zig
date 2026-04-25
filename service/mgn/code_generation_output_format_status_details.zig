const CodeGenerationOutputFormatStatus = @import("code_generation_output_format_status.zig").CodeGenerationOutputFormatStatus;

/// Status details for a specific code generation output format.
pub const CodeGenerationOutputFormatStatusDetails = struct {
    /// The status of the code generation for this output format.
    status: ?CodeGenerationOutputFormatStatus = null,

    /// A list of detailed status information for the code generation.
    status_detail_list: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "status",
        .status_detail_list = "statusDetailList",
    };
};
