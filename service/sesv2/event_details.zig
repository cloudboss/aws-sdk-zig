const Bounce = @import("bounce.zig").Bounce;
const Complaint = @import("complaint.zig").Complaint;

/// Contains a `Bounce` object if the event type is `BOUNCE`.
/// Contains a `Complaint` object if the event type is `COMPLAINT`.
pub const EventDetails = struct {
    /// Information about a `Bounce` event.
    bounce: ?Bounce,

    /// Information about a `Complaint` event.
    complaint: ?Complaint,

    pub const json_field_names = .{
        .bounce = "Bounce",
        .complaint = "Complaint",
    };
};
