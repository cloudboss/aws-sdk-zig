const GenerationStatus = @import("generation_status.zig").GenerationStatus;

/// Contains information about a generation request made for the bot locale.
pub const GenerationSummary = struct {
    /// The date and time at which the generation request was made.
    creation_date_time: ?i64,

    /// The unique identifier of the generation request.
    generation_id: ?[]const u8,

    /// The status of the generation request.
    generation_status: ?GenerationStatus,

    /// The date and time at which the generation request was last updated.
    last_updated_date_time: ?i64,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .generation_id = "generationId",
        .generation_status = "generationStatus",
        .last_updated_date_time = "lastUpdatedDateTime",
    };
};
