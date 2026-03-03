/// A span from a trace that has been ingested by the X-Ray service. A span
/// represents a unit of work or an operation performed by a service.
pub const Span = struct {
    /// The span document.
    document: ?[]const u8 = null,

    /// The span ID.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .document = "Document",
        .id = "Id",
    };
};
