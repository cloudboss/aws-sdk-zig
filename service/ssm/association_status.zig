const AssociationStatusName = @import("association_status_name.zig").AssociationStatusName;

/// Describes an association status.
pub const AssociationStatus = struct {
    /// A user-defined string.
    additional_info: ?[]const u8 = null,

    /// The date when the status changed.
    date: i64,

    /// The reason for the status.
    message: []const u8,

    /// The status.
    name: AssociationStatusName,

    pub const json_field_names = .{
        .additional_info = "AdditionalInfo",
        .date = "Date",
        .message = "Message",
        .name = "Name",
    };
};
