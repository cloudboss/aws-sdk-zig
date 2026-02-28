const AnalysisErrorType = @import("analysis_error_type.zig").AnalysisErrorType;
const Entity = @import("entity.zig").Entity;

/// Analysis error.
pub const AnalysisError = struct {
    /// The message associated with the analysis error.
    message: ?[]const u8,

    /// The type of the analysis error.
    @"type": ?AnalysisErrorType,

    /// Lists the violated entities that caused the analysis error
    violated_entities: ?[]const Entity,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
        .violated_entities = "ViolatedEntities",
    };
};
