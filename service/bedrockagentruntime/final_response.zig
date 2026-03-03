const Metadata = @import("metadata.zig").Metadata;

/// Contains details about the response to the user.
pub const FinalResponse = struct {
    /// Contains information about the invoke agent operation.
    metadata: ?Metadata = null,

    /// The text in the response to the user.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "metadata",
        .text = "text",
    };
};
