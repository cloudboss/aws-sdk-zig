const CloseStatus = @import("close_status.zig").CloseStatus;

/// Used to filter the closed workflow executions in visibility APIs by their
/// close status.
pub const CloseStatusFilter = struct {
    /// The close status that must match the close status of an execution for it to
    /// meet the criteria of
    /// this filter.
    status: CloseStatus,

    pub const json_field_names = .{
        .status = "status",
    };
};
