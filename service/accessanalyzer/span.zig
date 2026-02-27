const Position = @import("position.zig").Position;

/// A span in a policy. The span consists of a start position (inclusive) and
/// end position (exclusive).
pub const Span = struct {
    /// The end position of the span (exclusive).
    end: Position,

    /// The start position of the span (inclusive).
    start: Position,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
