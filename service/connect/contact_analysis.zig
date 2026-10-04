const Transcript = @import("transcript.zig").Transcript;

/// A structure that defines search criteria for contacts using analysis outputs
/// from Connect Customer Contact
/// Lens.
pub const ContactAnalysis = struct {
    /// Search criteria based on transcript analyzed by Connect Customer Contact
    /// Lens.
    transcript: ?Transcript = null,

    pub const json_field_names = .{
        .transcript = "Transcript",
    };
};
