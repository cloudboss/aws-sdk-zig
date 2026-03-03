const Geometry = @import("geometry.zig").Geometry;
const SelectionStatus = @import("selection_status.zig").SelectionStatus;

/// The results extracted for a lending document.
pub const LendingDetection = struct {
    /// The confidence level for the text of a detected value in a lending document.
    confidence: ?f32 = null,

    geometry: ?Geometry = null,

    /// The selection status of a selection element, such as an option button or
    /// check box.
    selection_status: ?SelectionStatus = null,

    /// The text extracted for a detected value in a lending document.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .geometry = "Geometry",
        .selection_status = "SelectionStatus",
        .text = "Text",
    };
};
