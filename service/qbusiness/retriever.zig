const RetrieverStatus = @import("retriever_status.zig").RetrieverStatus;
const RetrieverType = @import("retriever_type.zig").RetrieverType;

/// Summary information for the retriever used for your Amazon Q Business
/// application.
pub const Retriever = struct {
    /// The identifier of the Amazon Q Business application using the retriever.
    application_id: ?[]const u8 = null,

    /// The name of your retriever.
    display_name: ?[]const u8 = null,

    /// The identifier of the retriever used by your Amazon Q Business application.
    retriever_id: ?[]const u8 = null,

    /// The status of your retriever.
    status: ?RetrieverStatus = null,

    /// The type of your retriever.
    @"type": ?RetrieverType = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .display_name = "displayName",
        .retriever_id = "retrieverId",
        .status = "status",
        .@"type" = "type",
    };
};
