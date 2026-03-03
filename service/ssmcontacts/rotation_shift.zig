const ShiftDetails = @import("shift_details.zig").ShiftDetails;
const ShiftType = @import("shift_type.zig").ShiftType;

/// Information about a shift that belongs to an on-call rotation.
pub const RotationShift = struct {
    /// The Amazon Resource Names (ARNs) of the contacts who are part of the shift
    /// rotation.
    contact_ids: ?[]const []const u8 = null,

    /// The time a shift rotation ends.
    end_time: i64,

    /// Additional information about an on-call rotation shift.
    shift_details: ?ShiftDetails = null,

    /// The time a shift rotation begins.
    start_time: i64,

    /// The type of shift rotation.
    @"type": ?ShiftType = null,

    pub const json_field_names = .{
        .contact_ids = "ContactIds",
        .end_time = "EndTime",
        .shift_details = "ShiftDetails",
        .start_time = "StartTime",
        .@"type" = "Type",
    };
};
