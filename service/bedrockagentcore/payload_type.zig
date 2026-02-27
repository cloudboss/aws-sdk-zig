const Conversational = @import("conversational.zig").Conversational;

/// Contains the payload content for an event.
pub const PayloadType = union(enum) {
    /// The binary content of the payload.
    blob: ?[]const u8,
    /// The conversational content of the payload.
    conversational: ?Conversational,

    pub const json_field_names = .{
        .blob = "blob",
        .conversational = "conversational",
    };
};
